//
//  TestViewController.m
//  asOne
//
//  Created by JoshJSZ on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (nonatomic, strong) AODeviceInfoHub *infoHub;

@end

@implementation TestViewController

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
