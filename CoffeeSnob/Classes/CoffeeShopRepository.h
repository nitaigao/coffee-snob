//
//  CoffeeShopRepository.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 06/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface CoffeeShopRepository : NSObject {
	
	NSMutableData *coffeeResponseData;
	id loadedDelegate;
	CLLocation* userLocation;

}

- (void) findAll:(id)delegate fromUserLocation:(CLLocation*)location;

@end