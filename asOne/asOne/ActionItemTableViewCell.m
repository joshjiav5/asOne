//
//  ActionItemTableViewCell.m
//  asOne
//
//  Created by JoshJSZ on 7/12/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "ActionItemTableViewCell.h"

@implementation ActionItemTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    [self.actionItemView.layer setCornerRadius:3.0f];
    self.actionItemView.clipsToBounds = YES;
    self.actionItemView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        self.actionItemView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    } else {
        self.actionItemView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.3];
    }
}
@end
