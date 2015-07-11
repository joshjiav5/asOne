//
//  AODeviceInfoHub.h
//  asOne
//
//  Created by JoshJSZ on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AODevInfoBattery;

@interface AODeviceInfoHub : NSObject

- (AODevInfoBattery *)getBatteryInfo;

@end

@interface AODevInfoBattery : NSObject

@property (nonatomic) float batteryLevel;
@property (nonatomic) UIDeviceBatteryState batteryState;

- (instancetype)initWithBatteryLevel:(float)batLevel state:(UIDeviceBatteryState)batState;

@end