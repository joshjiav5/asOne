//
//  AOBackend.h
//  asOne
//
//  Created by Revan Sopher on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AODeviceInfoHub.h"

@interface AOBackend : NSObject

+ (void)postBatteryStatus:(AODevInfoBattery *)battery
        andLocationStatus:(CLLocation *)location;
//+ (void)postLocationStatus:(CLLocation *)location;
+ (NSArray *)getFriendStatus;

@end
