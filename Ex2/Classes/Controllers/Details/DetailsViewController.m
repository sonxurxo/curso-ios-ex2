//
//  DetailsViewController.m
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

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
    
    self.nameLabel.text = [self.element objectForKey:@"name"];
    self.jobLabel.text = [self.element objectForKey:@"job"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapAlertNameButton:(id)sender {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Alerta!" message:[self.element objectForKey:@"name"] delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"No hacer nada", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        NSLog(@"Clicked cancel button");
    }
    else
    {
        switch (buttonIndex) {
            case 1:
                NSLog(@"Clicked do nothing button");
                break;
                
            default:
                break;
        }
    }
}

- (IBAction)didTapActionSheetButton:(id)sender
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Opciones" delegate:self cancelButtonTitle:@"Descartar" destructiveButtonTitle:@"Destruir" otherButtonTitles:@"Otro", @"Otro más", @"Y Otro", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        NSLog(@"Clicked cancel button");
    }
    else if (buttonIndex == actionSheet.destructiveButtonIndex)
    {
        NSLog(@"Clicked destroy button");
    }
    else
    {
        switch (buttonIndex) {
            case 1:
                NSLog(@"Clicked Otro");
                break;
            case 2:
                NSLog(@"Clicked Otro más");
                break;
            case 3:
                NSLog(@"Clicked Y Otro");
                break;
                
            default:
                break;
        }
    }
}

@end
