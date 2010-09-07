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

NSString * const SELECTED = @"selected";
NSString * const ANNOTATION_SELECTED = @"annotationselected";
NSString * const PINANNOTATION_ID = @"CustomPinAnnotation";

- (MKAnnotationView *)createAnnotationView:(MKMapView *)map annotation:(id)annotation  {	
	CoffeeShopMapAnnotationView* view = (CoffeeShopMapAnnotationView*)[map dequeueReusableAnnotationViewWithIdentifier:PINANNOTATION_ID];
	if (!view)
	{
		view = [[[CoffeeShopMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PINANNOTATION_ID] autorelease];
		[view addObserver:self forKeyPath:SELECTED options:NSKeyValueObservingOptionNew context:ANNOTATION_SELECTED];	
	}
	else
	{
		view.annotation = annotation;
	}	
	return view;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
	NSObject<MKAnnotation>* annotation = [[mapView annotations] lastObject];
	if ([annotation isKindOfClass:[MKUserLocation class]]) return;
	[mapView selectAnnotation:annotation animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
	return [self createAnnotationView: map annotation: annotation];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(CoffeeShopMapAnnotationView*)object change:(NSDictionary *)change context:(void *)context{
	if([(NSString*)context isEqualToString:ANNOTATION_SELECTED]){
		if ([viewController respondsToSelector:@selector(selectedMapAnnotationChanged:)]) {
			[viewController performSelector:@selector(selectedMapAnnotationChanged:) withObject:object.annotation];
		}
	}
}

@end
