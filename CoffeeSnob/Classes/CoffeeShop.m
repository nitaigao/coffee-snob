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

- (CoffeeShopAnnotation*) getMapAnnotation {
	CoffeeShopAnnotation* coffeeShopAnnotation = [[CoffeeShopAnnotation alloc]init];
	coffeeShopAnnotation.coffeeShopName = name;
	coffeeShopAnnotation.coordinate = location.coordinate;
	return coffeeShopAnnotation;
}

@end
