//
//  CoffeeShop.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 06/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CoffeeShopMapAnnotation.h"
#import "GDataXMLNode.h"

@interface CoffeeShop : NSObject {
	NSString* name;
	NSString* description;
	CLLocation* location;
	CLLocation* userLocation;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) CLLocation* location;

- (id)initWithXml:(GDataXMLNode*)xml andUserLocation:(CLLocation*)location;
- (CoffeeShopMapAnnotation*) getMapAnnotation;
- (NSNumber*) distanceFromUser;
- (NSNumber*) distanceFromLocation:(CLLocation*)otherLocation;

@end
