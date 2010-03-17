//
//  CoffeeShopList.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 04/03/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoffeeShopList.h"


@interface CoffeeShopTableDataSource : NSObject<UITableViewDataSource> {
	IBOutlet UITableView *coffeeShops;
	CoffeeShopList *coffeeShopData;
	id delegate;
}

- (void)shopsLoaded:(CoffeeShopList*)shops delegate:(id)selectedDelegate;

@end
