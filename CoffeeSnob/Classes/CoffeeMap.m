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
	//map.self;
	return self;
}


- (void)showUserLocation {
	mapView.showsUserLocation = YES;
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
    
	// If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;

	// Try to dequeue an existing pin view first.
	MKPinAnnotationView* pinView = (MKPinAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotation"];
	
	if (!pinView)
	{
		// If an existing pin view was not available, create one
		pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation
												   reuseIdentifier:@"CustomPinAnnotation"]
				   autorelease];
		pinView.pinColor = MKPinAnnotationColorRed;
		pinView.animatesDrop = YES;
		pinView.canShowCallout = YES;
		
		// Add a detail disclosure button to the callout.
		UIButton* rightButton = [UIButton buttonWithType:
								 UIButtonTypeDetailDisclosure];
		[rightButton addTarget:self action:@selector(myShowDetailsMethod:)
			  forControlEvents:UIControlEventTouchUpInside];
		pinView.rightCalloutAccessoryView = rightButton;
	}
	else
		pinView.annotation = annotation;
	
	return pinView;

}

-(IBAction)myShowDetailsMethod{
	NSLog(@"Here");
}

- (void)addCoffeeShops:(NSArray*)coffeeShops {		
	//need better place for this....
	mapView.delegate = self;
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
