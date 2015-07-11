//
//  AODeviceInfoHub.m
//  asOne
//
//  Created by JoshJSZ on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "AODeviceInfoHub.h"

@implementation AODeviceInfoHub

- (AODevInfoBattery *)getBatteryInfo {
    UIDevice *myDevice = [UIDevice currentDevice];
    [myDevice setBatteryMonitoringEnabled:YES];
    float batLeft = [myDevice batteryLevel];
    UIDeviceBatteryState batState = [myDevice batteryState];
    
    return [[AODevInfoBattery alloc] initWithBatteryLevel:batLeft state:batState];
}

@end

@implementation AODevInfoBattery

- (instancetype)initWithBatteryLevel:(float)batLevel state:(UIDeviceBatteryState)batState {
    self = [super init];
    if (self) {
        self.batteryLevel = batLevel;
        self.batteryState = batState;
    }
    return self;
}

@end
