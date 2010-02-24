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

#import "CoffeeShopMap.h"

@interface MapViewController : UIViewController<CLLocationManagerDelegate>{
	CLLocationManager* locationManager;
	NSLock *lock;
	bool isGettingCoffee;
	IBOutlet CoffeeShopMap* coffeeMap;
}

- (IBAction) nextButtonClicked:(id)sender;

@end
