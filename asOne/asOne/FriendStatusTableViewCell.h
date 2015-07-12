//
//  FriendStatusTableViewCell.h
//  asOne
//
//  Created by JoshJSZ on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendStatusTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *friendsContentView;
@property (weak, nonatomic) IBOutlet UIImageView *friendPic;
@property (weak, nonatomic) IBOutlet UILabel *friendStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendDistance;
@property (weak, nonatomic) IBOutlet UIImageView *batteryImageView;


@end
