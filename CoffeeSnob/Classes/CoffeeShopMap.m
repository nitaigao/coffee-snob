//
//  CoffeeMap.m
//  CoffeeSnob
//
//  Created by Mark H on 22/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CoffeeShopMap.h"


@implementation CoffeeShopMap

- (id)init {
	[super init];
	coffeeShops = [[CoffeeShopList alloc]init];
	return self;
}

- (void)showUserLocation {
	mapView.showsUserLocation = YES;
}

- (void) createAnnotationForShop:(CoffeeShop *)bestCoffeeShop  {
	CoffeeShopMapAnnotation* coffeeShopAnnotation = [bestCoffeeShop getMapAnnotation];
	[mapView addAnnotation:coffeeShopAnnotation];
	[mapView selectAnnotation:coffeeShopAnnotation animated:YES];	
}

- (void) zoomMapToUserAndShop:(CoffeeShop *)coffeeShop  {
	
	double longitudeDifference = (coffeeShop.location.coordinate.longitude - mapView.userLocation.coordinate.longitude);
	double latitudeDifference = (coffeeShop.location.coordinate.latitude - mapView.userLocation.coordinate.latitude);

	double centerMapLongitude = mapView.userLocation.coordinate.longitude + (longitudeDifference / 2);
	double centerMapLatitude = mapView.userLocation.coordinate.latitude + (latitudeDifference / 2);

	MKCoordinateRegion region;
	region.center = [[[CLLocation alloc]initWithLatitude:centerMapLatitude longitude:centerMapLongitude] coordinate];
	region.span.latitudeDelta = (latitudeDifference > 0) ? latitudeDifference : -latitudeDifference;
	region.span.longitudeDelta = (longitudeDifference > 0) ? longitudeDifference : -longitudeDifference;

	[mapView setRegion:region animated:TRUE];
}

- (void) showNextCoffeeShopToUser {
	CoffeeShop* coffeeShop = [coffeeShops getNextCoffeeShop];
	[self createAnnotationForShop: coffeeShop];
	[self zoomMapToUserAndShop: coffeeShop];
}

- (void)loadCoffeeShops { 
	[[[CoffeeShopRepository alloc] init] findAll:self];	
}

- (void)shopsLoaded:(NSMutableArray *)shops {
	[coffeeShops addCoffeeShops:shops userLocation:mapView.userLocation.location];
	[self showNextCoffeeShopToUser];
}


@end
