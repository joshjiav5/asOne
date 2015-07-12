//
//  AODeviceInfoHub.m
//  asOne
//
//  Created by JoshJSZ on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "AODeviceInfoHub.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface AODeviceInfoHub ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) AVAudioRecorder *recorder;

@end

@implementation AODeviceInfoHub

- (AODevInfoBattery *)getBatteryInfo {
    UIDevice *myDevice = [UIDevice currentDevice];
    [myDevice setBatteryMonitoringEnabled:YES];
    float batLeft = [myDevice batteryLevel];
    UIDeviceBatteryState batState = [myDevice batteryState];
    
    return [[AODevInfoBattery alloc] initWithBatteryLevel:batLeft state:batState];
}

- (void)askLocationPermission {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
}

- (void)updateLocationInDelegate {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    // Start getting location updates
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [manager stopUpdatingLocation];
    if (self.delegate && [self.delegate respondsToSelector:@selector(updatedLoaction:)]) {
        CLLocation *lastLocation = [locations lastObject];
        if (lastLocation) {
            [self.delegate updatedLoaction:lastLocation];
        }
    }
}

- (void)startRecording {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSString *urlString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSURL *url = [NSURL URLWithString:[urlString stringByAppendingString:@"/test.caf"]];
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                              [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                              [NSNumber numberWithInt: 2],                         AVNumberOfChannelsKey,
                              [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                              nil];
    
    NSError *error;
    
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    if (self.recorder) {
        [self.recorder prepareToRecord];
        self.recorder.meteringEnabled = YES;
        [self.recorder recordForDuration:(NSTimeInterval)15];
        NSLog(@"Recording!");
    } else
        NSLog([error description]);
}

@end

@implementation AODevInfoBattery

- (instancetype)initWithBatteryLevel:(float)batLevel state:(UIDeviceBatteryState)batState {
    self = [super init];
    if (self) {
        self.batteryLevel = batLevel;
        self.batteryState = batState;
    }
    return self;
}

@end
