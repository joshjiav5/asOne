//
//  DetailInfoViewController.m
//  asOne
//
//  Created by JoshJSZ on 7/12/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "DetailInfoViewController.h"
#import "DetailMapTableViewCell.h"
#import "ActionItemTableViewCell.h"
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface DetailInfoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *actionTableView;
@property (strong, nonatomic) NSArray *actionItems;

@end

@implementation DetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViewStyle];
    [self setupActionItems];
    [self setupTableView];
    [self fillInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewStyle {
    self.profilePic.clipsToBounds = YES;
    [self.profilePic.layer setCornerRadius:self.profilePic.layer.frame.size.height/2.0];
    self.profilePic.layer.borderWidth = 0.5f;
    self.profilePic.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.statusLabel.textColor = [UIColor whiteColor];
    self.distanceLabel.textColor = [UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = self.userName;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.actionTableView.backgroundColor = [UIColor clearColor];

}

- (void)fillInfo {
    self.statusLabel.text = self.status;
    self.distanceLabel.text = self.distance;
    self.profilePic.image = self.profileImg;
    self.batStatus.image = self.batImg;
}

- (void)setupTableView {
    self.actionTableView.delegate = self;
    self.actionTableView.dataSource = self;
}

- (void)setupActionItems {
    self.actionItems = @[@"Detect audio", @"Ping", @"Notify group"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"mapCell"];
        if ([cell isKindOfClass:[DetailMapTableViewCell class]]) {
            DetailMapTableViewCell *mapCell = (DetailMapTableViewCell *)cell;
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            [annotation setCoordinate:self.location];
            MKCoordinateSpan span;
            span.latitudeDelta =  0.5;
            span.longitudeDelta = 0.5;
            MKCoordinateRegion region;
            
            region.center = self.location;
            region.span = span;
            [mapCell.mapView setRegion:region animated:YES];
            [annotation setTitle:self.userName]; //You can set the subtitle too
            [mapCell.mapView addAnnotation:annotation];
            [mapCell.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading];
        }
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"actionCell"];
        if ([cell isKindOfClass:[ActionItemTableViewCell class]]) {
            NSString *itemString = self.actionItems[indexPath.row - 1];
            ((ActionItemTableViewCell*)cell).actionItemLabel.text = itemString;
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.actionItems.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 140.0;
    } else {
        return 60.0;
    }
}

- (void)pingAction {
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:pushQuery];
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"Hey, is everything okay?",@"message",
                          @"page", @"title",
                          @"Please let your support network you're okay!", @"alert" ,
                          @"alarm.aiff",@"sound",
                          nil];
    [push setData:data];
    [push setQuery: pushQuery];
    [push sendPushInBackground];
}

- (void)recordAction {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        [self pingAction];
    }
    if (indexPath.row == 1) {
        [self recordAction];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
