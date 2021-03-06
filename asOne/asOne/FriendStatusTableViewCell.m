//
//  FriendStatusTableViewCell.m
//  asOne
//
//  Created by JoshJSZ on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "FriendStatusTableViewCell.h"

@implementation FriendStatusTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    [self.friendsContentView.layer setCornerRadius:3.0f];
    self.friendsContentView.clipsToBounds = YES;
    self.friendsContentView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.friendPic.layer setCornerRadius:self.friendPic.layer.frame.size.height/2.0];
    self.friendPic.clipsToBounds = YES;
    self.friendPic.layer.borderWidth = 0.5f;
    self.friendPic.layer.borderColor = [UIColor darkGrayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        self.friendsContentView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    } else {
        self.friendsContentView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
    }
}

@end
