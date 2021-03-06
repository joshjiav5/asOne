//
//  FriendsStatusViewController.m
//  asOne
//
//  Created by JoshJSZ on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "FriendsStatusViewController.h"
#import "FriendStatusTableViewCell.h"
#import "AOBackendInterface.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "AOUserModel.h"
#import "DetailInfoViewController.h"

@interface FriendsStatusViewController ()
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;
@property (weak, nonatomic) IBOutlet UIView *friendsTableViewFooterView;
@property (weak, nonatomic) IBOutlet UIView *bottomToolBar;
@property (strong, nonatomic) NSArray *friends;
@property (nonatomic, strong) AODeviceInfoHub *infoHub;
@property (nonatomic) NSInteger selectedRow;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation FriendsStatusViewController {
    CLLocation *myLocation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViewStyle];
    [self setupTableView];
    [self setupDataSource];
    [self setupPullToRefresh];
    NSLog(@"User: %@", [PFUser currentUser]);
    
    self.infoHub = [[AODeviceInfoHub alloc] init];
    self.infoHub.delegate = self;
    [self.infoHub updateLocationInDelegate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupDataSource];
}

- (void)updatedLoaction:(CLLocation *)location {
    myLocation = location;
    NSLog(@"Updating location");
    [AOBackend postBatteryStatus: self.infoHub.getBatteryInfo
               andLocationStatus: myLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewStyle {
    self.friendsTableView.backgroundColor = [UIColor clearColor];
    self.friendsTableViewFooterView.backgroundColor = [UIColor clearColor];
    self.bottomToolBar.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.9];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:245.0/255.0 green:165.0/255.0 blue:58.0/255.0 alpha:1.0];
    UIImage* logoImage = [UIImage imageNamed:@"logoSmall"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
}

- (void)setupTableView {
    self.friendsTableView.delegate = self;
    self.friendsTableView.dataSource = self;
    self.friendsTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0,self.friendsTableViewFooterView.frame.size.height - 2.0, 0);
}

- (void)setupDataSource {
    [AOBackend executeFriendQuery:^(NSArray *result, NSError *error) {
        [self getData:result];
    }];
}

- (void)setupPullToRefresh {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(setupDataSource)
                  forControlEvents:UIControlEventValueChanged];
    [self.friendsTableView addSubview:self.refreshControl];

}

- (void)getData:(NSArray *)array {
    self.friends = array;
    [self.friendsTableView reloadData];
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendsCell"];
    AOUser *user = self.friends[indexPath.row];
    if ([cell isKindOfClass:[FriendStatusTableViewCell class]]) {
        FriendStatusTableViewCell *friendCell = (FriendStatusTableViewCell *)cell;
        friendCell.friendPic.image = user.profilePic;
        friendCell.friendStatusLabel.text = user.status;
        
        if (myLocation && user.location) {
            double distance = [user.location distanceFromLocation: myLocation];
            if (distance < 999) {
                friendCell.friendDistance.text = [NSString stringWithFormat: @"%.1f m", distance];
            } else if (distance < 9999) {
                friendCell.friendDistance.text = [NSString stringWithFormat: @"%.0f m", distance];
            } else {
                friendCell.friendDistance.text = [NSString stringWithFormat: @">9999 m"];
            }
            
        } else {
            //TODO more elegant handling of no location
            friendCell.friendDistance.text = @"~10 m";
        }
        
        friendCell.batteryImageView.image = [self getBatteryImage: (user.batStatus.floatValue*100)];
    }
    return cell;
}

- (UIImage *)getBatteryImage:(int) bat {
    NSString *level = @"0";
    if (bat > 10) level = @"10";
    if (bat > 20) level = @"20";
    if (bat > 30) level = @"30";
    if (bat > 40) level = @"40";
    if (bat > 50) level = @"50";
    if (bat > 60) level = @"60";
    if (bat > 70) level = @"70";
    if (bat > 80) level = @"80";
    if (bat > 90) level = @"90";
    
    return [UIImage imageNamed: level];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (IBAction)touchPlusBtn:(UIButton *)sender {
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Add freinds!" message:@"Type the name of the freind you want to add!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add!", nil];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [av show];
}

- (IBAction)touchChatBtn:(UIButton *)sender {
    [self performSegueWithIdentifier:@"sendChat" sender:nil];
}

- (IBAction)touchXbtn:(UIButton *)sender {
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Confirmation" message:@"Are you sure you want to be removed from the group?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes!", nil];
    [av show];
}

- (IBAction)touchSettingBtn:(UIButton *)sender {
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Settings" message:@"This will have all the settings!\n\nCredits:\n\nRevan Sopher\nJosh (Shaozhuo) Jia\nJeff Shaw\nMuhammad Ibrahim\nBrian Kim" delegate:self cancelButtonTitle:@"Okay!" otherButtonTitles: nil];
    [av show];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"showDetail" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        DetailInfoViewController *c = [segue destinationViewController];
        AOUser *u = self.friends[self.selectedRow];
        c.userName = u.name;
        c.profileImg = u.profilePic;
        c.status = u.status;
        c.location = u.location.coordinate;
        if (myLocation) {
            double distance = [u.location distanceFromLocation: myLocation];
            c.distance = [NSString stringWithFormat: @"%.1f m", distance];
        } else {
            //TODO more elegant handling of no location
            c.distance = @"~10 m";
        }
        c.batImg = [self getBatteryImage: u.batStatus.intValue];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
