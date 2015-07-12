//
//  ActionItemTableViewCell.h
//  asOne
//
//  Created by JoshJSZ on 7/12/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *actionItemLabel;
@property (weak, nonatomic) IBOutlet ActionItemTableViewCell *actionItemView;

@end
