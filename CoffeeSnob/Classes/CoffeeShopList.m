//
//  CoffeeShopList.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 23/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShopList.h"

@implementation CoffeeShopList

- (id)init {
	[super init];
	sortedShops = [[NSMutableArray alloc]init];
	coffeeShopsWithDistance = [[NSMutableDictionary alloc]init];	
	return self;
}

- (void)addCoffeeShops:(NSArray *)coffeeShops userLocation:(CLLocation*)userLocation {
	for(CoffeeShop *shop in coffeeShops) {		
		NSNumber* absoluteDistanceFromUser = [shop getDistanceFrom:userLocation];
		[sortedShops addObject:absoluteDistanceFromUser];
		[coffeeShopsWithDistance setValue:shop forKey:[absoluteDistanceFromUser stringValue]];
	}
	
	[sortedShops sortUsingSelector:@selector(compare:)];	
}

- (CoffeeShop*)getNextCoffeeShop {
	static NSInteger currentShopIndex = 0;
	currentShopIndex = currentShopIndex >= sortedShops.count ? 0 : currentShopIndex;	
	return [coffeeShopsWithDistance objectForKey:[[sortedShops objectAtIndex:currentShopIndex++] stringValue]];
}

@end
