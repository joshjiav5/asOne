//
//  AODeviceInfoHub.h
//  asOne
//
//  Created by JoshJSZ on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class AODevInfoBattery;

@protocol AODeviceInfoHubDelegate <NSObject>
@optional
- (void)updatedLoaction:(CLLocation *)location;

@end

@interface AODeviceInfoHub : NSObject <CLLocationManagerDelegate>

@property (nonatomic, weak) id <AODeviceInfoHubDelegate> delegate;

- (AODevInfoBattery *)getBatteryInfo;
- (void)updateLocationInDelegate;

@end

@interface AODevInfoBattery : NSObject

@property (nonatomic) float batteryLevel;
@property (nonatomic) UIDeviceBatteryState batteryState;

- (instancetype)initWithBatteryLevel:(float)batLevel state:(UIDeviceBatteryState)batState;

@end