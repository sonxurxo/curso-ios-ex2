//
//  MapAnnotation.h
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (strong, nonatomic) NSDictionary* place;

// Inicializa o annotation cun CLPlacemark e unha posición (esta decidirá que nome amosar: "C", "B"...)
- (id)initWithPlace:(NSDictionary*) place;

@end
