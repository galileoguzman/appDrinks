//
//  ViewController.m
//  appDrinks
//
//  Created by Galileo Guzman on 16/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import "Home.h"
#import "SWRevealViewController/SWRevealViewController.h"

NSMutableArray *bares;

@interface Home ()

@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Configure SWReveal for Menu
    
    self.title = @"Home";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.barButtonMenu setTarget: self.revealViewController];
        [self.barButtonMenu setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    
    //Get all data from parse
    
    bares = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"bar"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            for (id obj in objects){
                [bares addObject:obj];
                NSLog(@"bares %d", (int)[bares count]);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    NSLog(@"Total de registros obtenidos desde parse %d", (int)[bares count]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
