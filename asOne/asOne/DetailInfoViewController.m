//
//  DetailInfoViewController.m
//  asOne
//
//  Created by JoshJSZ on 7/12/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "DetailInfoViewController.h"
#import "ActionItemTableViewCell.h"

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
}

- (void)setupTableView {
    self.actionTableView.delegate = self;
    self.actionTableView.dataSource = self;
}

- (void)setupActionItems {
    self.actionItems = @[@"View footprint", @"Detect audio", @"Ping", @"Notify group"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"actionCell"];
    if ([cell isKindOfClass:[ActionItemTableViewCell class]]) {
        ((ActionItemTableViewCell*)cell).actionItemLabel.text = self.actionItems[indexPath.row];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.actionItems.count;
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
