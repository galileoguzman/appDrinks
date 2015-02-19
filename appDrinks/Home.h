//
//  Home.h
//  appDrinks
//
//  Created by Galileo Guzman on 19/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/PFQueryTableViewController.h>


@interface Home : PFQueryTableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButtonMenu;
- (IBAction)btnRefreshData:(id)sender;

@end
