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
	//map.delegate = self;
	return self;
}


- (void)showUserLocation {
	map.showsUserLocation = YES;
}

<<<<<<< HEAD
- (MKAnnotationView *)mapView:(MKMapView *)mapView
			viewForAnnotation:(id <MKAnnotation>)annotation {
    
	// If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;

	// Try to dequeue an existing pin view first.
	MKPinAnnotationView* pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotation"];
	
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
	map.delegate = self;
	
	for(int i = 0; i < coffeeShops.count; i++) {
		
		CoffeeShop* shop = [coffeeShops objectAtIndex:i];
		
		double distanceFromUser = [shop.location getDistanceFrom:map.userLocation.location];
		
		if (distanceFromUser < 0 ) {
			distanceFromUser = distanceFromUser * -1;
		}
=======
- (void)addCoffeeShops:(NSArray*)coffeeShops {		
	for(CoffeeShop *shop in coffeeShops) {		
		double distanceFromUser = [shop.location getDistanceFrom:mapView.userLocation.location];
		distanceFromUser = distanceFromUser < 0 ? distanceFromUser * -1 : distanceFromUser;
>>>>>>> bf6ab7aacb394d58b63415df44d40f2353d3679e
		
		NSNumber* absoluteDistanceFromUser = [[NSNumber alloc]initWithDouble: distanceFromUser];
		[sortedShops addObject:absoluteDistanceFromUser];
		[coffeeShopsWithDistance setValue:shop forKey:[absoluteDistanceFromUser stringValue]];
	}
	
	[sortedShops sortUsingSelector:@selector(compare:)];	
}

- (void) showClosestToUser {
<<<<<<< HEAD
	NSNumber* bestCoffeeShopKey = [sortedShops objectAtIndex:0];
	NSString* bestCoffeeShopKeyString = [NSString stringWithFormat:@"%@", bestCoffeeShopKey];
	CoffeeShop* bestCoffeeShop = [coffeeShopsWithDistance objectForKey:bestCoffeeShopKeyString];
	
=======
	CoffeeShop* bestCoffeeShop = [coffeeShopsWithDistance objectForKey:[[sortedShops objectAtIndex:0] stringValue]];

>>>>>>> bf6ab7aacb394d58b63415df44d40f2353d3679e
	CoffeeShopAnnotation* coffeeShopAnnotation = [bestCoffeeShop getMapAnnotation];
	[map addAnnotation:coffeeShopAnnotation];
	[map selectAnnotation:[map.annotations objectAtIndex:1] animated:YES];
	
	double longitudeDifference = (bestCoffeeShop.location.coordinate.longitude - map.userLocation.coordinate.longitude);
	double latitudeDifference = (bestCoffeeShop.location.coordinate.latitude - map.userLocation.coordinate.latitude);
	
	double longitudeDefferenceMidpoint = longitudeDifference / 2;
	double latitudeDifferenceMidpoint = latitudeDifference / 2;
	
	double centerMapLongitude = map.userLocation.coordinate.longitude + longitudeDefferenceMidpoint;
	double centerMapLatitude = map.userLocation.coordinate.latitude + latitudeDifferenceMidpoint;
	
	CLLocation* centerMapLocation = [[CLLocation alloc]initWithLatitude:centerMapLatitude longitude:centerMapLongitude];
	
	MKCoordinateSpan span;
	span.latitudeDelta = (latitudeDifference > 0) ? latitudeDifference : -latitudeDifference;
	span.longitudeDelta = (longitudeDifference > 0) ? longitudeDifference : -longitudeDifference;
	
	MKCoordinateRegion region;
	region.center = centerMapLocation.coordinate;
	region.span = span;
	
	[map setRegion:region animated:TRUE];
}

@end
