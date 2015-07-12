//
//  DetailMapTableViewCell.h
//  asOne
//
//  Created by JoshJSZ on 7/12/15.
//  Copyright (c) 2015 asOne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DetailMapTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end
