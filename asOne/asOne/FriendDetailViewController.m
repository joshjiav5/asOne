//
//  FriendDetailViewController.m
//  asOne
//
//  Created by JoshJSZ on 7/12/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "FriendDetailViewController.h"
#import "StatusUpdateTableViewCell.h"
#import "AOBackendInterface.h"

@interface FriendDetailViewController ()

@property (nonatomic, strong) NSArray *statuses;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBarBtn;

@end

@implementation FriendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViewStyle];
    [self setupTableView];
    [self setupBarBtn];
    self.statuses = @[@"Let’s go home",
                      @"Staying the night",
                      @"Already left",
                      @"Home safe",
                      @"On my way",
                      @"Be there in 10 mins",
                      @"Be there in 30 min"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell"];
    if ([cell isKindOfClass:[StatusUpdateTableViewCell class]]) {
        ((StatusUpdateTableViewCell *)cell).status.text = self.statuses[indexPath.row];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}

- (void)setupViewStyle {
//    self.friendsTableView.backgroundColor = [UIColor clearColor];
//    self.friendsTableViewFooterView.backgroundColor = [UIColor clearColor];
//    self.bottomToolBar.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.9];
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    UIImage* logoImage = [UIImage imageNamed:@"logoSmall"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
    self.statusUpdateTableView.backgroundColor = [UIColor clearColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)setupTableView {
    self.statusUpdateTableView.delegate = self;
    self.statusUpdateTableView.dataSource = self;
    self.statusUpdateTableView.backgroundColor = [UIColor clearColor];
}

- (void)setupBarBtn {
    self.cancelBarBtn.target = self;
    self.cancelBarBtn.action = @selector(pressCancelBtn);
}

- (void)pressCancelBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [AOBackend setStatus:self.statuses[indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
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
