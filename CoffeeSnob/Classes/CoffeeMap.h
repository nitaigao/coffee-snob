//
//  CoffeeMap.h
//  CoffeeSnob
//
//  Created by Mark H on 22/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CoffeeShop.h"

@interface CoffeeMap : NSObject<MKMapViewDelegate> {
	
	IBOutlet MKMapView* map;
	
	NSMutableArray* sortedShops;
	NSMutableDictionary* coffeeShopsWithDistance;

}

- (void)showUserLocation;
- (void)addCoffeeShops:(NSArray*)coffeeShops;
- (void)showClosestToUser;

@end
