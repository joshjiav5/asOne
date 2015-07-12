//
//  AOBackend.m
//  asOne
//
//  Created by Revan Sopher on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "AOBackendInterface.h"
#import <Parse/Parse.h>

@implementation AOBackend

+ (void)postBatteryStatus:(AODevInfoBattery *)battery
        andLocationStatus:(CLLocation *)location {
    //    PFObject *testObject = [PFObject objectWithClassName:@"User"];
    PFUser *user = [PFUser currentUser];
    user[@"battery"] = [NSNumber numberWithFloat: battery.batteryLevel];
    user[@"location"] = [PFGeoPoint geoPointWithLocation: location];
    
    [user saveInBackground];
}

//+ (void)postLocationStatus:(CLLocation *)location {
//
//}

+ (NSArray *)getFriendStatus {
    return nil;
}

@end
