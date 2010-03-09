//
//  CoffeeShopView.m
//  CoffeeSnob
//
//  Created by Mark H on 28/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapSummaryView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MapSummaryView

@synthesize name;
@synthesize description;
@synthesize image;

- (id)initWithCoder:(NSCoder *)aDecoder {
	[super initWithCoder:aDecoder];
	
	self.layer.cornerRadius = 11;
	return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
