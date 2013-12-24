//
//  FirstViewController.m
//  Ex2
//
//  Created by Xurxo Méndez Pérez on 24/12/13.
//  Copyright (c) 2013 SmartGalApps. All rights reserved.
//

#import "FirstViewController.h"

#import "DetailsViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
{
    NSArray* _elements;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _elements = @[
                  @{@"name" : @"Xurxo", @"job" : @"CEO"},
                  @{@"name" : @"Pilar", @"job" : @"CEO"},
                  @{@"name" : @"Manuel", @"job" : @"Developer"},
                  @{@"name" : @"Jorge", @"job" : @"Developer"},
                  @{@"name" : @"Miguel", @"job" : @"Developer"},
                  @{@"name" : @"Ana", @"job" : @"Developer"},
                  @{@"name" : @"María", @"job" : @"Developer"},
                  @{@"name" : @"Jose", @"job" : @"Designer"},
                  @{@"name" : @"Pepe", @"job" : @"Designer"},
                  @{@"name" : @"Javier", @"job" : @"Designer"},
                  @{@"name" : @"Noelia", @"job" : @"Marketing"},
                  @{@"name" : @"Marta", @"job" : @"Marketing"}];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _elements.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 44;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    
    CellIdentifier = @"ElementCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary* element = [_elements objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [element objectForKey:@"name"];
    cell.detailTextLabel.text = [element objectForKey:@"job"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Details"])
    {
        UITableViewCell* cell = (UITableViewCell*)sender;
        NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
        
        DetailsViewController* detailsViewController = segue.destinationViewController;
        detailsViewController.element = [_elements objectAtIndex:indexPath.row];
    }
}

@end
