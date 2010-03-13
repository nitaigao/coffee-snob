//
//  CoffeeShopAnnotation.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 06/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShopMapAnnotation.h"


@implementation CoffeeShopMapAnnotation

@synthesize coordinate;
@synthesize coffeeShopName;
@synthesize coffeeShopDescription;

- (NSString*) title {
	return coffeeShopName;
}

- (UIImage*) getCoffeeShopImage {
	NSString* imageName = [NSString stringWithFormat:@"%@.jpg", [coffeeShopName lowercaseString]];
	UIImage* image = [UIImage imageNamed:imageName];
	
	if (image == nil)
	{
		image = [UIImage imageNamed:@"coffee.jpg"];
	}	
	
	return image;
}

@end
