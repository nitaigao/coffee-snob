//
//  CoffeeShopList.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 04/03/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CoffeeShopList : NSObject<UITableViewDataSource> {
	IBOutlet UITableView *coffeeShops;
	NSMutableArray *coffeeShopData;
	id delegate;
}

- (void)shopsLoaded:(NSMutableArray*)shops delegate:(id)selectedDelegate;

@end
