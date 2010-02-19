//
//  FirstViewController.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 05/02/2010.
//  Copyright Black Art Studios 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "CoffeeShopRepository.h"


@interface FirstViewController : UIViewController< CLLocationManagerDelegate, CoffeeShopRepositoryDelegate >{
	
	IBOutlet MKMapView *coffeeView;
	
	CoffeeShopRepository* coffeeShopRepository;
	
	CLLocationManager* locationManager;
	CLLocation* currentLocation;
}

@property (retain, nonatomic) CLLocationManager* locationManager;
@property (retain, nonatomic) CLLocation* currentLocation;
@property (nonatomic, retain) CoffeeShopRepository* coffeeShopRepository;

@end
