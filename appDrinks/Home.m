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
        self.objectsPerPage = 15;
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
    
    cell.imgBar.image = [UIImage imageNamed:@"imageBar"];
    PFFile *thumbnail = [object objectForKey:@"imageBar"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell.imgBar];
    thumbnailImageView.image = [UIImage imageNamed:@"drink.png"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    //cell.imageView.image = [UIImage imageNamed:@"note"];
    // Configure the cell
    //PFFile *thumbnail = [object objectForKey:@"imageFile"];
    //PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    //thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    //thumbnailImageView.file = thumbnail;
    //[thumbnailImageView loadInBackground];
    
    return cell;
}

- (void) objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    //NSLog(@"error: %@", [error localizedDescription]);
}- (IBAction)btnRefreshData:(id)sender {
}
@end
