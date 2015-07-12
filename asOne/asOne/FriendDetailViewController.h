//
//  FriendDetailViewController.h
//  asOne
//
//  Created by JoshJSZ on 7/12/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "MasterViewController.h"

@interface FriendDetailViewController : MasterViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *statusUpdateTableView;

@end
