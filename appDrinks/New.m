//
//  New.m
//  appDrinks
//
//  Created by Galileo Guzman on 19/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import "New.h"
#import <Parse/Parse.h>

@interface New ()

@end

@implementation New

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnSaveInParseSender:(id)sender {
    
    
    
    
    if ([self.lblNameBar.text isEqualToString:@""]  || [self.lblDescriptionBar.text isEqualToString:@""] || [self.lblLatitudeBar.text isEqualToString:@""] || [self.lblLongitudeBar.text isEqualToString:@""]) {
        
        //statements
        NSLog(@"Todos los campos son necesarios");
        
    }else{
        PFObject *obj = [PFObject objectWithClassName:@"bar"];
        
        obj[@"name"] = self.lblNameBar.text;
        obj[@"description"] = self.lblDescriptionBar.text;
        obj[@"latitude"] = self.lblLatitudeBar.text;
        obj[@"longitude"] = self.lblLongitudeBar.text;
        
        [obj saveInBackground];
        
        self.lblNameBar.text = nil;
        self.lblDescriptionBar.text = nil;
        self.lblLatitudeBar.text = @"";
        self.lblLongitudeBar.text = @"";
        
        [self performSegueWithIdentifier:@"backToHomeFromNew" sender:self];
    }
    
    
}

- (IBAction)btnCancelSender:(id)sender {
    [self performSegueWithIdentifier:@"backToHomeFromNew" sender:self];
}
@end
