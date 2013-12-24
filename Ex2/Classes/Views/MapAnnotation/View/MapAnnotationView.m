//
//  MapAnnotationView.m
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import "MapAnnotationView.h"

@implementation MapAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil)
    {
        self.frame = CGRectMake(0, 0, 30, 40);
        self.centerOffset = CGPointMake(0, -20);
        
        UIImageView* backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
        backgroundImageView.image = [UIImage imageNamed:@"ElementMarker"];
        [self addSubview:backgroundImageView];
    }
    return self;
}

@end
