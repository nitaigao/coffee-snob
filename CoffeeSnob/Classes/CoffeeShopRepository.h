//
//  CoffeeShopRepository.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 06/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoffeeShopRepository : NSObject {
	
	NSMutableData *coffeeResponseData;
	id loadedDelegate;

}

- (void) findAll:(id)delegate;

@end