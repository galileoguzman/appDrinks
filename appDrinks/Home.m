//
//  ViewController.m
//  appDrinks
//
//  Created by Galileo Guzman on 16/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import "Home.h"
#import "SWRevealViewController/SWRevealViewController.h"

@interface Home ()

@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Home";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.barButtonMenu setTarget: self.revealViewController];
        [self.barButtonMenu setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
