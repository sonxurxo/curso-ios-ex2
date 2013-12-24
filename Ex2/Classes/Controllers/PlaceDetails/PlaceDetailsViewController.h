//
//  PlaceDetailsViewController.h
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceDetailsViewController : UIViewController

@property (strong, nonatomic) NSDictionary* place;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@end
