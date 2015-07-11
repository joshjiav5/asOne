//
//  AODeviceInfoHub.m
//  asOne
//
//  Created by JoshJSZ on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "AODeviceInfoHub.h"

@interface AODeviceInfoHub ()

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation AODeviceInfoHub

- (AODevInfoBattery *)getBatteryInfo {
    UIDevice *myDevice = [UIDevice currentDevice];
    [myDevice setBatteryMonitoringEnabled:YES];
    float batLeft = [myDevice batteryLevel];
    UIDeviceBatteryState batState = [myDevice batteryState];
    
    return [[AODevInfoBattery alloc] initWithBatteryLevel:batLeft state:batState];
}

- (void)askLocationPermission {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
}

- (void)updateLocationInDelegate {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    // Start getting location updates
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [manager stopUpdatingLocation];
    if (self.delegate && [self.delegate respondsToSelector:@selector(updatedLoaction:)]) {
        CLLocation *lastLocation = [locations lastObject];
        if (lastLocation) {
            [self.delegate updatedLoaction:lastLocation];
        }
    }
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
