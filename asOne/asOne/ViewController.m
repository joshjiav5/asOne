//
//  ViewController.m
//  asOne
//
//  Created by JoshJSZ on 7/11/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) AODeviceInfoHub *hub;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.hub = [[AODeviceInfoHub alloc] init];
    self.hub.delegate = self;
    [self.hub updateLocationInDelegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updatedLoaction:(CLLocation *)location {
    self.labelOne.text = [NSString stringWithFormat:@"Lat: %f", location.coordinate.latitude];
    self.labelTwo.text = [NSString stringWithFormat:@"Log: %f", location.coordinate.longitude];
}

- (IBAction)pressGetLocation:(UIButton *)sender {
    [self.hub updateLocationInDelegate];
}

@end
