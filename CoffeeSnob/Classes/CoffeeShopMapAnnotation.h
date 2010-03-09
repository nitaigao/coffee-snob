//
//  CoffeeShopAnnotation.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 06/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CoffeeShopMapAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString* coffeeShopName;
	NSString* coffeeShopDescription;
	UIImage* coffeeShopImage;
}

- (UIImage*) getCoffeeShopImage;
- (NSString*) title;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) NSString* coffeeShopName;
@property (nonatomic, assign) NSString* coffeeShopDescription;

@end
