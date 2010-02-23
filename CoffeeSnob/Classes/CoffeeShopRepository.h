//
//  CoffeeShopRepository.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 06/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoffeeShopRepositoryDelegate.h"

@interface CoffeeShopRepository : NSObject {
	
	NSMutableData *coffeeResponseData;
	NSMutableArray *coffeeData;
	NSMutableArray *coffeeShops;
	id<CoffeeShopRepositoryDelegate> loadedDelegate;

}

- (void) findAll:(id<CoffeeShopRepositoryDelegate>) delegate;

@property (nonatomic, retain) NSMutableData *coffeeResponseData;
@property (nonatomic, retain) id<CoffeeShopRepositoryDelegate> loadedDelegate;

@end