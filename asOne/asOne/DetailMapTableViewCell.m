//
//  DetailMapTableViewCell.m
//  asOne
//
//  Created by JoshJSZ on 7/12/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "DetailMapTableViewCell.h"

@implementation DetailMapTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    [self.mapView.layer setCornerRadius:3.0f];
    self.mapView.clipsToBounds = YES;
    self.mapView.alpha = 0.9;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
