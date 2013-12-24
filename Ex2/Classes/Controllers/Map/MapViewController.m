//
//  MapViewController.m
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import "MapViewController.h"

#import <AddressBook/AddressBook.h>

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
    
    UIBarButtonItem* actionsBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(didTapActionsBarButtonItem:)];
    self.navigationItem.rightBarButtonItem = actionsBarButtonItem;
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
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
        
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

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
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

-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [self.mapView
         addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}

- (void)didTapActionsBarButtonItem:(id)sender
{
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    // Claves en AddressBook/ABPerson.h
    NSDictionary* addressDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"Ourense", kABPersonAddressCityKey,
                                       @"Spain", kABPersonAddressCountryKey,
                                       @"es", kABPersonAddressCountryCodeKey,
                                       @"Celso Emilio Ferreiro 40", kABPersonAddressStreetKey,
                                       @"32004", kABPersonAddressZIPKey,
                                       nil];
    
    [geocoder geocodeAddressDictionary:addressDictionary completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark* firstResult = placemarks.firstObject;
        
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
        
        request.source = [MKMapItem mapItemForCurrentLocation];
        
        MKPlacemark* firstResultPlacemark = [[MKPlacemark alloc] initWithPlacemark:firstResult];
        
        request.destination = [[MKMapItem alloc] initWithPlacemark:firstResultPlacemark];
        request.requestsAlternateRoutes = YES;
        MKDirections *directions =
        [[MKDirections alloc] initWithRequest:request];
        
        [directions calculateDirectionsWithCompletionHandler:
         ^(MKDirectionsResponse *response, NSError *error) {
             if (error) {
                 // Handle Error
             } else {
                 [self showRoute:response];
             }
         }];
        
        
    }];
}

@end
