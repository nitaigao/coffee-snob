//
//  CoffeeShopMapAnnotationView.m
//  CoffeeSnob
//
//  Created by Mark H on 27/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "CoffeeShopMapAnnotationView.h"

#define kHeight 50
#define kWidth  50
#define kBorder 2

@implementation CoffeeShopMapAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];	
	self.canShowCallout = YES;
	self.selected = TRUE;
	self.pinColor = MKPinAnnotationColorRed;
	
	//self.backgroundColor = [UIColor whiteColor];
	//self.frame = CGRectMake(0, 0, kWidth, kHeight);
	//UIImage* image = [UIImage imageNamed:@"coffee.jpg"];
	//imageView = [[UIImageView alloc] initWithImage:image];	
	//imageView.frame = CGRectMake(kBorder, kBorder, kWidth - 2 * kBorder, kWidth - 2 * kBorder);
	//[self addSubview:imageView];
	
	return self;
}

-(void) dealloc
{
	//[imageView release];
	[super dealloc];
}

@end
