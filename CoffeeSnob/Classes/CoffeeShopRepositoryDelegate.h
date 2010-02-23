//
//  CoffeeShopRepositoryDelegate.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 24/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CoffeeShopRepositoryDelegate <NSObject>

@optional
- (void)shopsLoaded:(NSMutableArray*)coffeeShops;

@end
