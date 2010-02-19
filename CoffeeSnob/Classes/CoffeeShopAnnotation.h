//
//  CoffeeShopAnnotation.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 06/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#import "CoffeeShop.h"

@interface CoffeeShopAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	CoffeeShop* coffeeShop;
}

- (NSString *)title;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) CoffeeShop *coffeeShop;

@end
