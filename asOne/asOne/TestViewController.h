//
//  TestViewController.h
//  asOne
//
//  Created by JoshJSZ on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AODeviceInfoHub.h"
#import <CoreLocation/CoreLocation.h>

@interface TestViewController : UIViewController <AODeviceInfoHubDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;

@end
