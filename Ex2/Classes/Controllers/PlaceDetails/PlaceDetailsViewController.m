//
//  PlaceDetailsViewController.m
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import "PlaceDetailsViewController.h"

@interface PlaceDetailsViewController ()

@end

@implementation PlaceDetailsViewController

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
    
    self.nameLabel.text = [self.place objectForKey:@"name"];
    self.typeLabel.text = [self.place objectForKey:@"type"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
