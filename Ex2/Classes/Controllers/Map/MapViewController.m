//
//  MapViewController.m
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import "MapViewController.h"

#import <AddressBook/AddressBook.h>

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
    CLLocation* location = [locations firstObject];
    self.positionLabel.text = [NSString stringWithFormat:@"My position is %f, %f", location.coordinate.latitude, location.coordinate.longitude];
}

#pragma mark -

- (IBAction)didTapReverseGeocodeButton:(id)sender {
    if (_locationManager.location)
    {
        CLGeocoder* geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:_locationManager.location completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark* firstResult = placemarks.firstObject;
            NSLog(@"Country: %@", firstResult.country);
            NSLog(@"Administrative area: %@", firstResult.administrativeArea);
            NSLog(@"Subadministrative area: %@", firstResult.subAdministrativeArea);
            NSLog(@"Locality: %@", firstResult.locality);
            NSLog(@"Sublocality: %@", firstResult.subLocality);
            NSLog(@"Postal code: %@", firstResult.postalCode);
            NSLog(@"Thoroughfata: %@", firstResult.thoroughfare);
            NSLog(@"Subthoroughfata: %@", firstResult.subThoroughfare);
        }];
    }
}

- (IBAction)didTapGeocodeButton:(id)sender {
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
        NSLog(@"Location: %f, %f", firstResult.location.coordinate.latitude, firstResult.location.coordinate.longitude);
    }];
}
@end
