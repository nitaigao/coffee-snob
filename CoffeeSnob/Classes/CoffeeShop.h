//
//  CoffeeShop.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 06/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface CoffeeShop : NSObject {
	
	NSString* name;
	CLLocation* coordinate;

}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) CLLocation* coordinate;

@end
