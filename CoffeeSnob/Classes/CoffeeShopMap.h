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

@interface CoffeeShopMap : NSObject<CoffeeShopRepositoryDelegate> {
	IBOutlet MKMapView* mapView;
	CoffeeShopList* coffeeShops;
}

- (void)showUserLocation;
- (void)showNextCoffeeShopToUser;
- (void)loadCoffeeShops;

@end
