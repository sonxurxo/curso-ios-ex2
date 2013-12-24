//
//  MapViewController.m
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import "MapViewController.h"

#import "MapAnnotation.h"
#import "MapAnnotationView.h"

#import "PlaceDetailsViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
{
    CLLocationManager* _locationManager;
    
    NSArray* _places;
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
    
    CLLocation* lastLocation = _locationManager.location;
    
    if (_locationManager.location)
    {
        lastLocation = _locationManager.location;
    }
    else
    {
        lastLocation = [[CLLocation alloc] initWithLatitude:43.339709 longitude:-7.0];
    }
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(lastLocation.coordinate, 100000, 100000) animated:NO];
    
    _places = @[
                   @{@"location" : [[CLLocation alloc] initWithLatitude:43.5 longitude:-7], @"name" : @"Bar Pepe", @"type" : @"Bar"},
                   @{@"location" : [[CLLocation alloc] initWithLatitude:43.2 longitude:-6.8], @"name" : @"Casa Manolo", @"type" : @"Restaurante"}
                   ];
    
    NSMutableArray* annotations = [@[] mutableCopy];
    for (NSDictionary* place in _places)
    {
        [annotations addObject:[[MapAnnotation alloc] initWithPlace:place]];
    }
    [self.mapView addAnnotations:annotations];
    
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

#pragma mark - MKMapView

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MapAnnotationView *annotationView = nil;
    
    static NSString *defaultPinID = @"MapAnnotationView";
    annotationView = (MapAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if (annotationView == nil)
    {
        annotationView = [[MapAnnotationView alloc]
                                 initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    }
    
    annotationView.canShowCallout = YES;
    annotationView.draggable = NO;
    annotationView.enabled = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoLight];
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"Details" sender:view.annotation];
}

#pragma mark - 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Details"])
    {
        MapAnnotation *mapAnnotation = (MapAnnotation*)sender;
        
        PlaceDetailsViewController* placeDetailsViewController = segue.destinationViewController;
        placeDetailsViewController.place = mapAnnotation.place;
    }
}

@end
