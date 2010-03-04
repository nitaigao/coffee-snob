//
//  CoffeeShopList.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 04/03/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShopList.h"
#import "CoffeeShop.h"

@implementation CoffeeShopList

- (void)shopsLoaded:(NSMutableArray*)shops {
	coffeeShopData = shops;	
	[coffeeShops reloadData];	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return coffeeShopData.count; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString* tableIdentifier = @"identifier";
	
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier: tableIdentifier] autorelease];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	CoffeeShop *coffeeShop = [coffeeShopData objectAtIndex:indexPath.row];
	
	cell.textLabel.text = coffeeShop.name;
	
	return cell;
}

@end
