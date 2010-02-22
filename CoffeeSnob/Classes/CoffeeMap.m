//
//  CoffeeMap.m
//  CoffeeSnob
//
//  Created by Mark H on 22/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CoffeeMap.h"


@implementation CoffeeMap

- (id)init {
	[super init];
	sortedShops = [[NSMutableArray alloc]init];
	coffeeShopsWithDistance = [[NSMutableDictionary alloc]init];
	
	return self;
}


- (void)showUserLocation {
	mapView.showsUserLocation = YES;
}

- (void)addCoffeeShops:(NSArray*)coffeeShops {		
	for(CoffeeShop *shop in coffeeShops) {		
		double distanceFromUser = [shop.location getDistanceFrom:mapView.userLocation.location];
		distanceFromUser = distanceFromUser < 0 ? distanceFromUser * -1 : distanceFromUser;
		
		NSNumber* absoluteDistanceFromUser = [[NSNumber alloc]initWithDouble: distanceFromUser];
		[sortedShops addObject:absoluteDistanceFromUser];
		[coffeeShopsWithDistance setValue:shop forKey:[absoluteDistanceFromUser stringValue]];
	}
	
	[sortedShops sortUsingSelector:@selector(compare:)];	
}

- (void) showClosestToUser {
	CoffeeShop* bestCoffeeShop = [coffeeShopsWithDistance objectForKey:[[sortedShops objectAtIndex:0] stringValue]];

	CoffeeShopAnnotation* coffeeShopAnnotation = [bestCoffeeShop getMapAnnotation];
	[mapView addAnnotation:coffeeShopAnnotation];
	[[mapView viewForAnnotation:coffeeShopAnnotation]setSelected:TRUE animated:TRUE];
	
	double longitudeDifference = (bestCoffeeShop.location.coordinate.longitude - mapView.userLocation.coordinate.longitude);
	double latitudeDifference = (bestCoffeeShop.location.coordinate.latitude - mapView.userLocation.coordinate.latitude);
	
	double longitudeDefferenceMidpoint = longitudeDifference / 2;
	double latitudeDifferenceMidpoint = latitudeDifference / 2;
	
	double centerMapLongitude = mapView.userLocation.coordinate.longitude + longitudeDefferenceMidpoint;
	double centerMapLatitude = mapView.userLocation.coordinate.latitude + latitudeDifferenceMidpoint;
	
	CLLocation* centerMapLocation = [[CLLocation alloc]initWithLatitude:centerMapLatitude longitude:centerMapLongitude];
	
	MKCoordinateSpan span;
	span.latitudeDelta = (latitudeDifference > 0) ? latitudeDifference : -latitudeDifference;
	span.longitudeDelta = (longitudeDifference > 0) ? longitudeDifference : -longitudeDifference;
	
	MKCoordinateRegion region;
	region.center = centerMapLocation.coordinate;
	region.span = span;
	
	[mapView setRegion:region animated:TRUE];
}

@end
