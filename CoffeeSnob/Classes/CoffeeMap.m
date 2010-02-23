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

- (void) setController:(UIViewController*)controller {
	viewController = controller;
}

- (void)showUserLocation {
	mapView.delegate = self;
	mapView.showsUserLocation = YES;
}

- (MKPinAnnotationView *) createPin: (MKMapView *) map annotation: (id) annotation  {
	MKPinAnnotationView* pinView = (MKPinAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotation"];

	if (!pinView)
	{
		pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotation"] autorelease];
		pinView.pinColor = MKPinAnnotationColorRed;
		pinView.canShowCallout = YES;
		
		UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[rightButton addTarget:self action:@selector(myShowDetailsMethod:) forControlEvents:UIControlEventTouchUpInside];
		pinView.rightCalloutAccessoryView = rightButton;
	}
	else
	{
		pinView.annotation = annotation;
	}
	
	return pinView;
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
	return [self createPin: map annotation: annotation];
}

-(IBAction)myShowDetailsMethod:(UIButton*)button{
	if ([viewController respondsToSelector:@selector(showCoffeeShopDetails:)]) {
		CoffeeShopAnnotation *annotation = [mapView.selectedAnnotations objectAtIndex:0];
		[viewController performSelector:@selector(showCoffeeShopDetails:) withObject:annotation.title];
	}
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

- (void) createAnnotationForShop: (CoffeeShop *) bestCoffeeShop  {
  CoffeeShopAnnotation* coffeeShopAnnotation = [bestCoffeeShop getMapAnnotation];
	[mapView addAnnotation:coffeeShopAnnotation];
	[mapView selectAnnotation:[mapView.annotations objectAtIndex:1] animated:YES];

}
- (void) showClosestToUser {
	CoffeeShop* bestCoffeeShop = [coffeeShopsWithDistance objectForKey:[[sortedShops objectAtIndex:0] stringValue]];

	[self createAnnotationForShop: bestCoffeeShop];
	
	double longitudeDifference = (bestCoffeeShop.location.coordinate.longitude - mapView.userLocation.coordinate.longitude);
	double latitudeDifference = (bestCoffeeShop.location.coordinate.latitude - mapView.userLocation.coordinate.latitude);
	
	double longitudeDefferenceMidpoint = longitudeDifference / 2;
	double latitudeDifferenceMidpoint = latitudeDifference / 2;

	MKCoordinateSpan span;
	span.latitudeDelta = (latitudeDifference > 0) ? latitudeDifference : -latitudeDifference;
	span.longitudeDelta = (longitudeDifference > 0) ? longitudeDifference : -longitudeDifference;
	
	double centerMapLongitude = mapView.userLocation.coordinate.longitude + longitudeDefferenceMidpoint;
	double centerMapLatitude = mapView.userLocation.coordinate.latitude + latitudeDifferenceMidpoint;
	
	CLLocation* centerMapLocation = [[CLLocation alloc]initWithLatitude:centerMapLatitude longitude:centerMapLongitude];	
	
	MKCoordinateRegion region;
	region.center = centerMapLocation.coordinate;
	region.span = span;
	
	[mapView setRegion:region animated:TRUE];
}

@end
