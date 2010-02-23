//
//  CoffeeMapDelegate.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 23/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShopMapDelegate.h"

@implementation CoffeeShopMapDelegate

- (MKPinAnnotationView *)createPin:(MKMapView *)map annotation:(id)annotation  {
	MKPinAnnotationView* pinView = (MKPinAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotation"];
	
	if (!pinView)
	{
		pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotation"] autorelease];
		pinView.pinColor = MKPinAnnotationColorRed;
		pinView.canShowCallout = YES;
		pinView.selected = TRUE;
		UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[rightButton addTarget:viewController action:@selector(showCoffeeShopDetails:) forControlEvents:UIControlEventTouchUpInside];
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

/*-(IBAction)showCoffeeShopDetails:(id)sender {
	if ([viewController respondsToSelector:@selector(showCoffeeShopDetails:)]) {
		CoffeeShopAnnotation *annotation = [mapView.selectedAnnotations objectAtIndex:0];
		[viewController performSelector:@selector(showCoffeeShopDetails:) withObject:annotation.title];
	}
}*/

@end
