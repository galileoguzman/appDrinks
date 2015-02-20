//
//  New.m
//  appDrinks
//
//  Created by Galileo Guzman on 19/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import "New.h"
#import <Parse/Parse.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


UIImage *chosenImage;

@interface New ()

@end

@implementation New

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xFE9A2E)];
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
        
        
        NSData *imageData = UIImagePNGRepresentation(chosenImage);
        PFFile *imageFile = [PFFile fileWithName:@"imageBar.png" data:imageData];
        obj[@"imageBar"] = imageFile;
        
        
        [obj saveInBackground];
        
        self.lblNameBar.text = nil;
        self.lblDescriptionBar.text = nil;
        self.lblLatitudeBar.text = nil;
        self.lblLongitudeBar.text = nil;
        self.imgImageBar = nil;
        
        [self performSegueWithIdentifier:@"backToHomeFromNew" sender:self];
    }
    
    
}

- (IBAction)btnCancelSender:(id)sender {
    [self performSegueWithIdentifier:@"backToHomeFromNew" sender:self];
}

- (IBAction)btnAddImage:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fotografia"
                                                    message:@"Elegir fotografía de"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancelar"
                                          otherButtonTitles:@"Camara", @"Carrete", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if(buttonIndex == 0)
    {
        NSLog(@"Cancelar");
    }
    else if(buttonIndex == 1)
    {
        NSLog(@"Camara");
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if(buttonIndex == 2)
    {
        NSLog(@"Carrete");
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    chosenImage = info[UIImagePickerControllerEditedImage];
    self.imgImageBar.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
