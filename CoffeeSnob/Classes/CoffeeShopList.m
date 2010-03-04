//
//  CoffeeShopList.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 04/03/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShopList.h"

@implementation CoffeeShopList

- (void)shopsLoaded:(NSMutableArray*)shops {
	coffeeShopData = shops;	
	[coffeeShops reloadData];	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return coffeeShopData.count; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

@end
