//
//  LoginViewController.m
//  asOne
//
//  Created by oprah on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "LoginViewController.h"


@implementation LoginViewController

-(void)viewDidLoad {
    
//    self.fbLoginButton.delegate = self;
//    self.fbLoginButton.readPermissions = @[@"public_profile", @"user_friends"];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions: [NSDictionary dictionary]];
    [self _loginWithFacebook];
    [self _loadFriendData];

    
//    if ([FBSDKAccessToken currentAccessToken]) {
//         User is logged in, do work such as go to next view controller.
//        NSLog(@"user is already logged it");
//        [self performSegueWithIdentifier:@"friendsView" sender:nil];
//    }
    
}

- (void)_loginWithFacebook {
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_friends", @"public_profile"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else {
            [self _loadPersonalData];
            if (user.isNew) {
                NSLog(@"User signed up and logged in through Facebook!");
            } else {
                NSLog(@"User logged in through Facebook!");
            }
            [self performSegueWithIdentifier:@"friendsView" sender:nil];
        }
        NSLog(@"Error %@:%@", error, [error userInfo]);
    }];
    
}

- (void)_loadPersonalData {
    // ...
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"/me" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSLog(@"Personal data: %@", userData);
            
            PFUser *user = [PFUser currentUser];
            user[@"realName"] = userData[@"name"];
            user[@"status"] = @"idle";
            user[@"groupNumber"] = @1; //TEMPORARY!
            user[@"pictureURL"] = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", userData[@"id"]];
            
            [user saveInBackground];
        } else {
            NSLog(@"Error %@:%@", error, [error userInfo]);
        }
    }];
}

- (void)_loadFriendData {
    // ...
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"/me/friends/" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSLog(@"Friend data: %@", userData);
        }
    }];
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    
//    [self _loadPersonalData];
//    [self _loadFriendData];

//    [self performSegueWithIdentifier:@"friendsView" sender:nil];
}

@end
