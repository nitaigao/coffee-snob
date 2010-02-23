//
//  CoffeeMapDelegate.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 23/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CoffeeShopMapDelegate : NSObject<MKMapViewDelegate> {
	IBOutlet UIViewController *viewController;
}

@end
