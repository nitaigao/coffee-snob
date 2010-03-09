//
//  CoffeeShopList.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 04/03/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShopList.h"
#import "CoffeeShop.h"
#import "CoffeeShopListTableCell.h"

@implementation CoffeeShopList

NSString* const CELLID = @"CoffeeShopListTableCell";


- (void)shopsLoaded:(NSMutableArray*)shops {
	coffeeShopData = shops;	
	[coffeeShops reloadData];	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return coffeeShopData.count; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {	
	CoffeeShopListTableCell *cell = (CoffeeShopListTableCell*)[tableView dequeueReusableCellWithIdentifier:CELLID];
	if (cell == nil)
	{
		cell = [[[CoffeeShopListTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLID]autorelease];
	}
	[cell setShop:[coffeeShopData objectAtIndex:indexPath.row]];
	return cell;	
}

@end
