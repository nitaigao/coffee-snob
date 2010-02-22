//
//  CoffeeShopAnnotation.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 06/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShopAnnotation.h"


@implementation CoffeeShopAnnotation

@synthesize coordinate;
@synthesize coffeeShopName;

- (NSString *)title {
	return coffeeShopName;
}

@end
