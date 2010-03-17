//
//  CoffeeShopList.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 23/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "CoffeeShop.h"


@interface CoffeeShopList : NSObject {

	NSMutableArray* sortedShops;
	NSMutableDictionary* coffeeShopsWithDistance;
	
}

- (void)addCoffeeShops:(NSArray *)coffeeShops userLocation:(CLLocation*)userLocation;
- (CoffeeShop*)getNextCoffeeShop;
- (NSInteger)getCount;
- (CoffeeShop*)getCoffeeShopAtIndex:(NSUInteger)index;

@end
