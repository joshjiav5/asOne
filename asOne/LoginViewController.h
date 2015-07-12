//
//  LoginViewController.h
//  asOne
//
//  Created by oprah on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "MasterViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>

@interface LoginViewController : MasterViewController <FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet FBSDKLoginButton  *fbLoginButton;

@end


