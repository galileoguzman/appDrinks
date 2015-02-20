//
//  New.h
//  appDrinks
//
//  Created by Galileo Guzman on 19/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface New : UIViewController
//Labels
@property (strong, nonatomic) IBOutlet UITextField *lblNameBar;
@property (strong, nonatomic) IBOutlet UITextField *lblDescriptionBar;
@property (strong, nonatomic) IBOutlet UITextField *lblLatitudeBar;
@property (strong, nonatomic) IBOutlet UITextField *lblLongitudeBar;

//Images

@property (strong, nonatomic) IBOutlet UIImageView *imgImageBar;

//Buttons
- (IBAction)btnSaveInParseSender:(id)sender;
- (IBAction)btnCancelSender:(id)sender;
- (IBAction)btnAddImage:(id)sender;

@end
