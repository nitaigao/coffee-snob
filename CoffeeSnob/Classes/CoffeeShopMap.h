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
	bool locationFound;
	CoffeeShopList* coffeeShops;
}

- (CLLocation*)getUserLocation;
- (void)startUpdatingLocation;
- (void)showNextCoffeeShopToUser;
- (void)showDirectionsToSelectedCoffeeShop;
- (void)shopsLoaded:(CoffeeShopList*)shops;
- (void)selectShop:(CoffeeShop*)coffeeShop;
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

@end
