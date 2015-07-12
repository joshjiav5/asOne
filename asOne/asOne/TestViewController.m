//
//  TestViewController.m
//  asOne
//
//  Created by JoshJSZ on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "TestViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>

@interface TestViewController ()

@property (nonatomic, strong) AODeviceInfoHub *infoHub;

@end

@implementation TestViewController

// TODO get working
- (void)_loadData {
    // ...
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        // handle response
    }];
}

// TODO get working
- (void)_loginWithFacebook {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            NSLog(@"User logged in through Facebook!");
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.infoHub = [[AODeviceInfoHub alloc] init];
    self.infoHub.delegate = self;
    [self.infoHub updateLocationInDelegate];
    [self updateBatStatus];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updatedLoaction:(CLLocation *)location {
    self.labelOne.text = [NSString stringWithFormat:@"Lat: %f, Log: %f", location.coordinate.latitude, location.coordinate.longitude];
}

- (void)updateBatStatus {
    AODevInfoBattery *batInfo = self.infoHub.getBatteryInfo;
    self.labelTwo.text = [NSString stringWithFormat:@"Level: %f, State: %ld", batInfo.batteryLevel, (long)batInfo.batteryState];
    
}

- (IBAction)pressGetNewInfo:(UIButton *)sender {
    [self.infoHub updateLocationInDelegate];
    [self updateBatStatus];
}

@end
