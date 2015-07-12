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

+ (void)executeFriendQuery:(void (^)(NSArray *result, NSError *error))block {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"groupNumber" equalTo:@1];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error.domain) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d users.", objects.count);

            NSMutableArray *users = [[NSMutableArray alloc] init];
            
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                
                AOUser *user = [AOUser alloc];
                user.name = object[@"realName"];
                user.uid = object[@"username"];
                user.batStatus = object[@"battery"];
                
                PFGeoPoint *point = object[@"location"];
                user.location = [[CLLocation alloc] initWithLatitude: point.latitude
                                                           longitude: point.longitude];
                user.email = object[@"email"];
                user.status = object[@"status"];
                user.activeGroupID = object[@"groupNumber"];
                user.microphoneActive = false;
                
                NSURL *url = [NSURL URLWithString:object[@"pictureURL"]];
                NSData * imageData = [[NSData alloc] initWithContentsOfURL:url];
                user.profilePic = [UIImage imageWithData: imageData];
                
                [users addObject:user];
            }
            
            block(users, error);
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

+ (void)setStatus: (NSString *)status {
    PFUser *user = [PFUser currentUser];
    user[@"status"] = status;
    [user saveInBackground];
    
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"deviceType" equalTo:@"ios"];
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:pushQuery];
    NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:@"message", status, @"Title", [PFUser currentUser][@"realName"], nil];
    [push setData:data];
    [push setQuery: pushQuery];
    [push sendPushInBackground];
}

@end
