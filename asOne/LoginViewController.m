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
    
    self.fbLoginButton.delegate = self;
    self.fbLoginButton.readPermissions = @[@"public_profile", @"user_friends"];
    
}

-(void)viewDidAppear:(BOOL)animated {
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        NSLog(@"user is already logged it");
        [self performSegueWithIdentifier:@"friendsView" sender:nil];
    }
    
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    [self performSegueWithIdentifier:@"friendsView" sender:nil];
}

@end
