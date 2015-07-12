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
            friendCell.friendDistance.text = [NSString stringWithFormat: @"%.1f m", distance];
        } else {
            //TODO more elegant handling of no location
            friendCell.friendDistance.text = @"~10 m";
        }
        
        //TODO do something with battery info
//        self.infoHub.getBatteryInfo;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (IBAction)touchPlusBtn:(UIButton *)sender {

}

- (IBAction)touchChatBtn:(UIButton *)sender {
    [self performSegueWithIdentifier:@"sendChat" sender:nil];
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
//        c.batStatus = u.batStatus;
        if (myLocation) {
            double distance = [u.location distanceFromLocation: myLocation];
            c.distance = [NSString stringWithFormat: @"%.1f m", distance];
        } else {
            //TODO more elegant handling of no location
            c.distance = @"~10 m";
        }
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
