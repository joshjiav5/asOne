//
//  AOBackend.m
//  asOne
//
//  Created by Revan Sopher on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "AOBackendInterface.h"
#import "AOUserModel.h"
#import <Parse/Parse.h>

static NSArray *friends;

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
    //friends might still be nil
    return friends;
}

+ (void)executeFriendQuery {
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query whereKey:@"groupNumber" equalTo:@1];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d users.", objects.count);

            NSMutableArray *users = [[NSMutableArray alloc] init];
            
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
                AOUser *user = [AOUser alloc];
                user.name = object[@"realName"];
                user.uid = object[@"username"];
                user.batStatus = object[@"battery"];
                user.location = object[@"location"];
                user.email = object[@"email"];
                user.status = object[@"status"];
                user.activeGroupID = object[@"groupNumber"];
                user.microphoneActive = false;
                user.profilePic = nil;
                
                [users addObject:user];
            }
            
            friends = objects;
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
