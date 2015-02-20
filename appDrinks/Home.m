//
//  Home.m
//  appDrinks
//
//  Created by Galileo Guzman on 19/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import "Home.h"
#import "SWRevealViewController/SWRevealViewController.h"
#import "Parse/Parse.h"
#import <ParseUI/PFTableViewCell.h>
#import <ParseUI/PFQueryTableViewController.h>
#import "CeldaBar.h"
#import "Detail.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface Home ()

@end

@implementation Home
- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"bar";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 9;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xFE9A2E)];
    
    self.title = @"Home";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.barButtonMenu setTarget: self.revealViewController];
        [self.barButtonMenu setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:@"bar"];
    
    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    static NSString *CellIdentifier = @"celdaBar";
    
    CeldaBar *cell = (CeldaBar *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CeldaBar alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    
    cell.lblNombreBar.text = [object objectForKey:@"name"];
    
    cell.lblDescripcionBar.text = [object objectForKey:@"description"];
   
    PFFile *theImage = [object objectForKey:@"imageBar"];
    [theImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error){
        
        NSData *imageFile = [theImage getData];
        //Set the animals Icon Image to what ever is intended.
        cell.imgBar.image = [UIImage imageWithData:imageFile];
    }];
    
    
    return cell;
}

- (void) objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    //NSLog(@"error: %@", [error localizedDescription]);
}

//Detail segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Detalle");
    if ([segue.identifier isEqualToString:@"showDetailView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Detail *detailBar = segue.destinationViewController;
        
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        detailBar.lblNameBar = [object objectForKey:@"name"];
        detailBar.imgBar = [object objectForKey:@"imageBar"];
        detailBar.lblDescription = [object objectForKey:@"description"];
        
    }
}

//Deleting row from parse dot com
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    PFObject *object = [self.objects objectAtIndex:indexPath.row];
    [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //[self refreshTable:nil];
    }];
}

- (IBAction)btnRefreshData:(id)sender {
}

@end
