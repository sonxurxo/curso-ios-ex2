//
//  MapViewController.m
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
{
    CLLocationManager* _locationManager;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = 1;
    [_locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
    
//    CLLocation* lastLocation = _locationManager.location;
//    
//    if (_locationManager.location)
//    {
//        lastLocation = _locationManager.location;
//    }
//    else
//    {
//        lastLocation = [[CLLocation alloc] initWithLatitude:42.339709 longitude:-8.670275];
//    }
//    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(lastLocation.coordinate, 10000, 10000) animated:NO];
    
    CLLocationCoordinate2D coordsGarage = CLLocationCoordinate2DMake(42.339709, -8.670275);
    CLLocationCoordinate2D blimpCoord = CLLocationCoordinate2DMake(42.309709, -8.700275);
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:coordsGarage fromEyeCoordinate:blimpCoord eyeAltitude:100];
    self.mapView.camera = camera;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Location manager delegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location Manager failed");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Location Manager updated location");
//    CLLocation* location = [locations firstObject];
}

#pragma mark -

@end
