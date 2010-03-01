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
	CLLocation* location;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) CLLocation* location;

- (id)initWithXml:(GDataXMLNode*)xml;
- (CoffeeShopMapAnnotation*) getMapAnnotation;
- (NSNumber*) getDistanceFrom:(CLLocation*)otherLocation;

@end
