//
//  SecondViewController.m
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import "SecondViewController.h"

#import "ElementCollectionCell.h"

#import "DetailsViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
{
    NSArray* _elements;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _elements = @[
                  @[
                      @{@"name" : @"Xurxo", @"job" : @"CEO"},
                      @{@"name" : @"Pilar", @"job" : @"CEO"}
                      ],
                  @[
                      @{@"name" : @"Manuel", @"job" : @"Developer"},
                      @{@"name" : @"Jorge", @"job" : @"Developer"},
                      @{@"name" : @"Miguel", @"job" : @"Developer"},
                      @{@"name" : @"Ana", @"job" : @"Developer"},
                      @{@"name" : @"María", @"job" : @"Developer"}
                      ],
                  @[
                      @{@"name" : @"Jose", @"job" : @"Designer"},
                      @{@"name" : @"Pepe", @"job" : @"Designer"},
                      @{@"name" : @"Javier", @"job" : @"Designer"}
                      ],
                  @[
                      @{@"name" : @"Noelia", @"job" : @"Marketing"},
                      @{@"name" : @"Marta", @"job" : @"Marketing"}
                      ]
                  ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollection datasource and delegate methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return _elements.count;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[_elements objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ElementCollectionCell";
    __weak ElementCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray* section = [_elements objectAtIndex:indexPath.section];
    
    NSDictionary* element = [section objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [element objectForKey:@"name"];
    cell.subtitleLabel.text = [element objectForKey:@"job"];
    cell.userImageView.image = [UIImage imageNamed:@"User"];
    
    return cell;
}

#pragma mark - 


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Details"])
    {
        ElementCollectionCell* cell = (ElementCollectionCell*)sender;
        NSIndexPath* indexPath = [self.collectionView indexPathForCell:cell];
        
        NSArray* section = [_elements objectAtIndex:indexPath.section];
        
        NSDictionary* element = [section objectAtIndex:indexPath.row];
        
        DetailsViewController* detailsViewController = segue.destinationViewController;
        detailsViewController.element = element;
    }
}

@end
