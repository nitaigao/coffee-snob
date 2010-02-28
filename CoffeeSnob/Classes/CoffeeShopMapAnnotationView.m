//
//  CoffeeShopMapAnnotationView.m
//  CoffeeSnob
//
//  Created by Mark H on 27/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import "CoffeeShopMapAnnotationView.h"
#import "CoffeeShopViewController.h"

#define kHeight 50
#define kWidth  50
#define kBorder 2

@implementation CoffeeShopMapAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
	self.frame = CGRectMake(0, 0, kWidth, kHeight);
	self.backgroundColor = [UIColor whiteColor];
	
	//CoffeeShopMapAnnotation* csAnnotation = (CoffeeShopMapAnnotation*)annotation;

	CoffeeShopViewController* aViewController = [[CoffeeShopViewController alloc] initWithNibName:@"CoffeeShopView" bundle:[NSBundle mainBundle]];
	[self addSubview: aViewController.view];

	self.canShowCallout = YES;
	self.selected = TRUE;

	//UIImage* image = [UIImage imageNamed:@"coffee.jpg"];
	//_imageView = [[UIImageView alloc] initWithImage:image];	
	//_imageView.frame = CGRectMake(kBorder, kBorder, kWidth - 2 * kBorder, kWidth - 2 * kBorder);
	//[self addSubview:_imageView];
	
	return self;
}

-(void) dealloc
{
	[_imageView release];
	[super dealloc];
}

@end
