//
//  CoffeeShopList.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 04/03/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShopTableDataSource.h"
#import "CoffeeShop.h"
#import "CoffeeShopListTableCell.h"

@implementation CoffeeShopTableDataSource

NSString* const CELLID = @"CoffeeShopListTableCell";

- (void)shopsLoaded:(CoffeeShopList*)shops delegate:(id)selectedDelegate {
	coffeeShopData = shops;	
	delegate = selectedDelegate;
	[coffeeShops reloadData];	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return coffeeShopData.getCount; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {	
	CoffeeShopListTableCell *cell = (CoffeeShopListTableCell*)[tableView dequeueReusableCellWithIdentifier:CELLID];
	if (cell == nil)
	{
		cell = [[[CoffeeShopListTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLID]autorelease];
	}
	CoffeeShop* coffeeShop = [coffeeShopData getCoffeeShopAtIndex:indexPath.row];
	[cell setShop:coffeeShop delegate:delegate];
	return cell;	
}

@end

