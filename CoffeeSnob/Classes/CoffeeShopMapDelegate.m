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

NSString * const ANNOTATION_SELECTED = @"annotationselected";
NSString * const ANNOTATION_DESELECTED = @"annotationdeselected";


- (MKAnnotationView *)createAnnotationView:(MKMapView *)map annotation:(id)annotation  {	
	CoffeeShopMapAnnotationView* view = (CoffeeShopMapAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotation"];
	if (!view)
	{
		view = [[[CoffeeShopMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotation"] autorelease];
		
		//Add an observer for the selected-property on the MKAnnotationView. Delegate to self.
		[view addObserver:self
			   forKeyPath:@"selected"
				  options:NSKeyValueObservingOptionNew
				  context:ANNOTATION_SELECTED];	
		
	}
	else
	{
		view.annotation = annotation;
	}	
	return view;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views;
{
    [mapView selectAnnotation:[[mapView annotations] lastObject] animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
	return [self createAnnotationView: map annotation: annotation];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(CoffeeShopMapAnnotationView*)object
						change:(NSDictionary *)change
					   context:(void *)context{
	
	NSString *action = (NSString*)context;
		
	if([action isEqualToString:ANNOTATION_SELECTED]){
		if ([viewController respondsToSelector:@selector(selectedMapAnnotationChanged:)]) {
			[viewController performSelector:@selector(selectedMapAnnotationChanged:) withObject:object.annotation];
		}
	}
}

@end
