//
//  FriendsStatusViewController.m
//  asOne
//
//  Created by JoshJSZ on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "FriendsStatusViewController.h"
#import "FriendStatusTableViewCell.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface FriendsStatusViewController ()
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;
@property (weak, nonatomic) IBOutlet UIView *friendsTableViewFooterView;
@property (weak, nonatomic) IBOutlet UIView *bottomToolBar;

@end

@implementation FriendsStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViewStyle];
    [self setupTableView];
    
    NSLog(@"User: %@", [PFUser currentUser]);
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendsCell"];
    if ([cell isKindOfClass:[FriendStatusTableViewCell class]]) {
        NSLog(@"Yeah!");
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (IBAction)touchPlusBtn:(UIButton *)sender {

}

- (IBAction)touchChatBtn:(UIButton *)sender {
    [self performSegueWithIdentifier:@"sendChat" sender:nil];
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
