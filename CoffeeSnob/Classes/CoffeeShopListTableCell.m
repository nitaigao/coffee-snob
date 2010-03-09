//
//  CoffeeShopListTableCell.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 08/03/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShopListTableCell.h"


@implementation CoffeeShopListTableCell

- (id)initWithFrame:(CGRect)aRect reuseIdentifier:(NSString *)identifier
{
	self = [super initWithFrame:aRect reuseIdentifier:identifier];
	if (self)
	{
		// you can do this here specifically or at the table level for all cells
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		// Create label views to contain the various pieces of text that make up the cell.
		// Add these as subviews.
		titleLabel = [[UILabel alloc] initWithFrame:CGRectZero]; // layoutSubViews will decide the final frame
		titleLabel.text = @"hello";
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.opaque = NO;
		titleLabel.textColor = [UIColor blackColor];
		titleLabel.highlightedTextColor = [UIColor whiteColor];
		titleLabel.font = [UIFont boldSystemFontOfSize:18];
		[self.contentView addSubview:titleLabel];
	}
	
	return self;
}

- (void)setDetail:(NSString*)title imageUrl:(NSString*)imageUrl distance:(NSString*)distance {
	//titleLabel.text = title;
	//distanceLabel.text = distance;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];
}


- (void)dealloc {
    [super dealloc];
}


@end
