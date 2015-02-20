//
//  Mapa.h
//  appDrinks
//
//  Created by Galileo Guzman on 18/02/15.
//  Copyright (c) 2015 Galileo Guzman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Mapa : UIViewController<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapMapBar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonMenu;


@end
