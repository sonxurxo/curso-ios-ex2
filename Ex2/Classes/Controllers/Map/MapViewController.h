//
//  MapViewController.h
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
