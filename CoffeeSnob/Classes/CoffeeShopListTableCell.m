//
//  CoffeeShopListTableCell.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 08/03/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShopListTableCell.h"


@implementation CoffeeShopListTableCell

- (void)setShop:(CoffeeShop*)shop delegate:(id)selectedDelegate {
	delegate = selectedDelegate;
	coffeeShop = shop;
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	self.selectionStyle = UITableViewCellSelectionStyleBlue;
	self.textLabel.text = shop.name;
	self.detailTextLabel.text = @"(130 yds)";
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
	UIImage *image = [UIImage imageWithContentsOfFile:path];
	self.imageView.image = image;
	self.imageView.backgroundColor = [UIColor redColor];		
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	if ([delegate respondsToSelector:@selector(listItemSelected:)] && selected) {
		[delegate performSelector:@selector(listItemSelected:) withObject:coffeeShop];
		self.selected = FALSE;
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
