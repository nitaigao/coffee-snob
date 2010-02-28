//
//  CoffeeMap.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 24/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "Describe_CoffeeShop.h"
#import "CoffeeShop.h"

#import <CoreLocation/CoreLocation.h>


@implementation Describe_CoffeeShop

- (void)it_should_calculate_the_distance_between_itself_and_another_location {
	CoffeeShop* shop = [[CoffeeShop alloc]init];
	shop.location = [[CLLocation alloc]initWithLatitude:10 longitude:10];
	NSNumber* distance = [shop getDistanceFrom:[[CLLocation alloc]initWithLatitude:9.9 longitude:9.9]];
	// somehow assert this
}

@end
