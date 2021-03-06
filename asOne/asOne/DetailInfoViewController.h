//
//  DetailInfoViewController.h
//  asOne
//
//  Created by JoshJSZ on 7/12/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "MasterViewController.h"
#import <MapKit/MapKit.h>

@interface DetailInfoViewController : MasterViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UIImageView *batStatus;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *distance;
@property (strong, nonatomic) UIImage *profileImg;
@property (strong, nonatomic) UIImage *batImg;
@property (nonatomic) CLLocationCoordinate2D location;
@property (nonatomic) float batLevel;

@end
