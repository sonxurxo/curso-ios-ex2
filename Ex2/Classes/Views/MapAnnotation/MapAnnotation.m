//
//  MapAnnotation.m
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

- (id)initWithPlace:(NSDictionary*) place
{
    if (self = [super init])
    {
        self.place = place;
    }
    return self;
}

- (CLLocationCoordinate2D) coordinate
{
    CLLocation* location = [self.place objectForKey:@"location"];
    return location.coordinate;
}

- (NSString*) title
{
    return [self.place objectForKey:@"name"];
}

- (NSString*) subtitle
{
    return [self.place objectForKey:@"type"];
}


@end
