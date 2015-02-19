//
//  ViewController.h
//  appDrinks
//
//  Created by Galileo Guzman on 16/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface Home : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonMenu;
- (IBAction)btnReloadDataSender:(id)sender;

@end

