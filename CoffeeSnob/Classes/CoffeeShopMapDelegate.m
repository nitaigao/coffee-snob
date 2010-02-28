//
//  CoffeeMapDelegate.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 23/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShopMapDelegate.h"
#import "CoffeeShopMapAnnotationView.h"

@implementation CoffeeShopMapDelegate

- (MKAnnotationView *)createView:(MKMapView *)map annotation:(id)annotation  {
	
	CoffeeShopMapAnnotationView* view = (CoffeeShopMapAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotation"];
	
	if (!view)
	{
		view = [[[CoffeeShopMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotation"] autorelease];
		
		UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[rightButton addTarget:viewController action:@selector(coffeeShopSelected) forControlEvents:UIControlEventTouchUpInside];
		view.rightCalloutAccessoryView = rightButton;
	}
	else
	{
		view.annotation = annotation;
	}
	
	return view;
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
	return [self createView: map annotation: annotation];
}

/*- (MKPinAnnotationView *)createPin:(MKMapView *)map annotation:(id)annotation  {
	MKPinAnnotationView* pinView = (MKPinAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotation"];
	
	if (!pinView)
	{
		pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotation"] autorelease];
		pinView.pinColor = MKPinAnnotationColorRed;
		pinView.canShowCallout = YES;
		pinView.selected = TRUE;
		UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[rightButton addTarget:viewController action:@selector(coffeeShopSelected) forControlEvents:UIControlEventTouchUpInside];
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
*/
@end
