//
//  Mapa.m
//  appDrinks
//
//  Created by Galileo Guzman on 18/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import "Mapa.h"
#import "SWRevealViewController/SWRevealViewController.h"
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface Mapa ()

@end

@implementation Mapa

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xFE9A2E)];
    self.title = @"Mapa";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.barButtonMenu setTarget: self.revealViewController];
        [self.barButtonMenu setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //configure MKMapKit
    
    MKCoordinateRegion region;
    
    CLLocationCoordinate2D location;
    location.latitude = 17.065754;
    location.longitude = -96.723048;
    region.center=location;
    
    MKUserLocation *userLocation = self.mapMapBar.userLocation;
    region = MKCoordinateRegionMakeWithDistance (userLocation.location.coordinate, 200, 200);
    
    [self.mapMapBar setRegion:region animated:TRUE];
    [self.mapMapBar regionThatFits:region];

    region.center = CLLocationCoordinate2DMake(location.latitude ,location.longitude);
    
    //Get cordinates from parse
    
    
    //Get data from parse
    
    PFQuery *query = [PFQuery queryWithClassName:@"bar"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        for(id object in objects){
            
            NSString *lat = object[@"latitude"];
            NSString *lon = object[@"longitude"];
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            CLLocationCoordinate2D locationAnnotation;
            locationAnnotation.latitude = [lat floatValue];
            locationAnnotation.longitude = [lon floatValue];
            annotation.title = object[@"name"];
            annotation.coordinate = locationAnnotation;
            
            [self.mapMapBar addAnnotation:annotation];
            
        }
    }];
    
    
    [self.mapMapBar setRegion:region animated:NO];
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

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    self.mapMapBar.centerCoordinate = userLocation.location.coordinate;
}

@end
