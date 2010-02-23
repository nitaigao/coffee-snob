//
//  CoffeeShop.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 06/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShop.h"


@implementation CoffeeShop

@synthesize name;
@synthesize location;

- (CoffeeShopMapAnnotation*) getMapAnnotation {
	CoffeeShopMapAnnotation* coffeeShopAnnotation = [[CoffeeShopMapAnnotation alloc]init];
	coffeeShopAnnotation.coffeeShopName = name;
	coffeeShopAnnotation.coordinate = location.coordinate;
	return coffeeShopAnnotation;
}


- (NSNumber*) getDistanceFrom:(CLLocation*)otherLocation {
	double distanceFromUser = [location getDistanceFrom:otherLocation];
	distanceFromUser = distanceFromUser < 0 ? distanceFromUser * -1 : distanceFromUser;
	return [[NSNumber alloc]initWithDouble:distanceFromUser];
}

@end
