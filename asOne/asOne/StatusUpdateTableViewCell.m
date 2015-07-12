//
//  StatusUpdateTableViewCell.m
//  asOne
//
//  Created by JoshJSZ on 7/12/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "StatusUpdateTableViewCell.h"

@implementation StatusUpdateTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.statusView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    [self.statusView.layer setCornerRadius:3.0f];
    self.statusView.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        self.statusView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    } else {
        self.statusView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    }
}

@end
