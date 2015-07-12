//
//  AOUser.h
//  asOne
//
//  Created by Revan Sopher on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AODeviceInfoHub.h"

@interface AOUser : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) AODevInfoBattery *batStatus;
@property (nonatomic, strong) CLLocation *locatione;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) UIImage *profilePic;
@property (nonatomic, strong) NSString *activeGroupID;
@property (nonatomic) BOOL microphoneActive;

@end
