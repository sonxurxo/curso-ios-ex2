//
//  DetailsViewController.h
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController<UIAlertViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSDictionary* element;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *jobLabel;

- (IBAction)didTapAlertNameButton:(id)sender;

- (IBAction)didTapActionSheetButton:(id)sender;

@end
