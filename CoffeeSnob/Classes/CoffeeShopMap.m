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
	coffeeShops = [[CoffeeShopsList alloc]init];
	locationManager = [[CLLocationManager alloc] init];
	lock = [[NSLock alloc]init];
	return self;
}

- (void)startUpdatingLocation {
	isGettingCoffee = false;
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
	locationManager.distanceFilter = 1; // or whatever
	[locationManager startUpdatingLocation];	
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	[lock lock];
	if (newLocation.horizontalAccuracy < 500 && !isGettingCoffee) {
		isGettingCoffee = true;
		[locationManager stopUpdatingLocation];
		if ([viewController respondsToSelector:@selector(locationUpdated)]) {
			[viewController performSelector:@selector(locationUpdated)];
		}
	}
	[lock unlock];
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

- (void)shopsLoaded:(NSMutableArray *)shops {
	[coffeeShops addCoffeeShops:shops userLocation:mapView.userLocation.location];
	[self showNextCoffeeShopToUser];
}

-(CLLocation *)getSelectedCoffeeShopLocation{	
	CoffeeShopMapAnnotation* coffeeShopAnnotation = [mapView.selectedAnnotations objectAtIndex:0];
	return [[CLLocation alloc]initWithLatitude:coffeeShopAnnotation.coordinate.latitude longitude:coffeeShopAnnotation.coordinate.longitude];
}

- (void)showDirectionsToSelectedCoffeeShop {
	CLLocation* coffeeShoplocation = [self getSelectedCoffeeShopLocation];
	NSString *startAddress = [NSString stringWithFormat: @"%f,%f", mapView.userLocation.coordinate.latitude, mapView.userLocation.coordinate.longitude];
    NSString *destination = [NSString stringWithFormat: @"%f,%f", coffeeShoplocation.coordinate.latitude, coffeeShoplocation.coordinate.longitude];
	NSString *url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%@&daddr=%@", startAddress, destination]; 
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
