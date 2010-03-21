//
//  CoffeeShopListTableCell.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 08/03/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShopListTableCell.h"


@implementation CoffeeShopListTableCell

- (UIImage*) getCoffeeShopImage:(CoffeeShop*)shop {
	NSString* imageName = [NSString stringWithFormat:@"%@.jpg", [shop.name lowercaseString]];
	UIImage* image = [UIImage imageNamed:imageName];
	
	if (image == nil)
	{
		image = [UIImage imageNamed:@"coffee.jpg"];
	}	
	
	return image;
}

- (void)setShop:(CoffeeShop*)shop delegate:(id)selectedDelegate {
	delegate = selectedDelegate;
	coffeeShop = shop;
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	self.selectionStyle = UITableViewCellSelectionStyleBlue;
	self.textLabel.text = shop.name;
	
	NSString* formatString = @"%.0f m";
	int distanceAbsolute = abs([[coffeeShop distanceFromUser] intValue]);
	float distance = distanceAbsolute;
	
	if (distance > 1000)
	{
		formatString = @"%.2f km";
		distance = distance / 1000;
	}
	
	NSString* distanceString = [[[NSString alloc]initWithFormat:formatString, distance] autorelease];
																	  	
	self.detailTextLabel.text = [[[NSString alloc] initWithFormat:@"(%@)", distanceString] autorelease]; 
	self.imageView.image = [self getCoffeeShopImage:shop];
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
