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

- (void)shopsLoaded:(NSMutableArray*)shops {
	coffeeShopData = shops;	
	[coffeeShops reloadData];	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return coffeeShopData.count; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString* kCellIdentifier = @"CoffeeShopListTableCell";
	
	CoffeeShopListTableCell *cell = (CoffeeShopListTableCell*)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	
	if (cell == nil)
	{
		cell = [[[CoffeeShopListTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:kCellIdentifier] autorelease];
		
	}
	
	
	return cell;	
	
	//CoffeeShop *coffeeShop = [coffeeShopData objectAtIndex:indexPath.row];
	//CoffeeShopListTableCell *cell = [[[CoffeeShopListTableCell alloc] initWithFrame:CGRectZero reuseIdentifier:tableIdentifier] autorelease];
	//[cell setDetail:coffeeShop.name imageUrl:@"" distance:@"(120 yds)"];
	
	
	//return cell;
}

@end
