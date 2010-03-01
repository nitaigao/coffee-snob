//
//  CoffeeMap.h
//  CoffeeSnob
//
//  Created by Mark H on 22/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CoffeeShop.h"
#import "CoffeeShopRepository.h"
#import "CoffeeShopList.h"

@interface CoffeeShopMap : NSObject<CLLocationManagerDelegate> {
	IBOutlet UIViewController *viewController;
	IBOutlet MKMapView* mapView;
	CLLocationManager* locationManager;
	NSLock *lock;
	bool isGettingCoffee;
	CoffeeShopList* coffeeShops;
}

- (void)startUpdatingLocation;
- (void)showUserLocation;
- (void)showNextCoffeeShopToUser;
- (void)loadCoffeeShops;
- (void)showDirectionsToSelectedCoffeeShop;

@end
