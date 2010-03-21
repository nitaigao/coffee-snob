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
@synthesize description;

- (void) dealloc {
	[super dealloc];
	[name release];
	[description release];
}

- (id)initWithXml:(GDataXMLNode*)xml andUserLocation:(CLLocation*)usersLocation  {
	[self init];
	userLocation = usersLocation;
	for (int j = 0; j < xml.children.count; j++) {
		GDataXMLNode *coffeeShopNodeXML = [xml.children objectAtIndex:j];
		
		if (![coffeeShopNodeXML.name compare:@"title"]) {
			name = [[NSString alloc] initWithString:[coffeeShopNodeXML stringValue]];
		}
		
		if (![coffeeShopNodeXML.name compare:@"description"]) {
			description = [[NSString alloc] initWithString:[coffeeShopNodeXML stringValue]];
		}
		
		if (![coffeeShopNodeXML.name compare:@"georss:point"]) {
			
			NSString* point = [coffeeShopNodeXML stringValue];
			point = [point stringByReplacingOccurrencesOfString:@"  " withString:@""];
			point = [point stringByReplacingOccurrencesOfString:@"\n" withString:@""];
			
			NSArray* latitudeLongitude = [point componentsSeparatedByString:@" "];
			NSString* longitude = [latitudeLongitude objectAtIndex:0];
			NSString* latitude = [latitudeLongitude objectAtIndex:1];
			
			location = [[CLLocation alloc]initWithLatitude:[longitude doubleValue] longitude:[latitude doubleValue] ];
		}
	}
	return self;
}

- (CoffeeShopMapAnnotation*) getMapAnnotation {
	CoffeeShopMapAnnotation* coffeeShopAnnotation = [[CoffeeShopMapAnnotation alloc]init];
	coffeeShopAnnotation.coffeeShopName = name;
	
	coffeeShopAnnotation.coordinate = location.coordinate;
	coffeeShopAnnotation.coffeeShopDescription = description;
	return coffeeShopAnnotation;
}

- (NSNumber*) distanceFromUser {
	return [self getDistanceFrom:userLocation];
}

- (NSNumber*) getDistanceFrom:(CLLocation*)otherLocation {
	double distanceFromUser = [location getDistanceFrom:otherLocation];
	distanceFromUser = distanceFromUser < 0 ? distanceFromUser * -1 : distanceFromUser;
	return [[[NSNumber alloc]initWithDouble:distanceFromUser] autorelease];
}

@end
