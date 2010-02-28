//
//  FirstViewController.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 05/02/2010.
//  Copyright Black Art Studios 2010. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CoffeeShopMapAnnotation.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[loadingView startAnimating:@"Finding You..."];
	[coffeeMap startUpdatingLocation];
}

- (void)locationUpdated {
	[coffeeMap showUserLocation];
	[loadingView setMessage:@"Finding Shops..."];
	[coffeeMap loadCoffeeShops];	
}

- (void) shopsLoaded {
	[loadingView stopAnimatingAndHide];
	[navigationBar setRightBarButtonItem:nextButton];
	[navigationBar setLeftBarButtonItem:listButton];
}

- (void) selectedMapAnnotationChanged:(CoffeeShopMapAnnotation*)annotation{
	coffeeShopView.name.text = annotation.coffeeShopName;
	NSString* imageName = [NSString stringWithFormat:@"%@.jpg", [annotation.coffeeShopName lowercaseString]];
	coffeeShopView.image.image = [UIImage imageNamed:imageName];
	[self.view addSubview:coffeeShopView];
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
	[self becomeFirstResponder];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (event.type == UIEventSubtypeMotionShake) {		
		[coffeeMap showNextCoffeeShopToUser];
	}
}

- (IBAction) directionsButtonClicked:(id)sender {
	[coffeeMap showDirectionsToSelectedCoffeeShop];
}

- (IBAction) hideButtonClicked:(id)sender {
	[coffeeShopView removeFromSuperview];
}

- (IBAction) nextButtonClicked:(id)sender {
	[coffeeMap showNextCoffeeShopToUser];
}

- (IBAction) flipButtonClicked:(id)sender {
	bool toMap = ![listButton.title compare:@"List"];
	[coffeeShopView removeFromSuperview];
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationDuration:.75];
	[UIView setAnimationTransition:toMap ? UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight forView:[self view] cache:YES];
	[self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
	[UIView commitAnimations];
	listButton.title = toMap ? @"Map" : @"List";
	navigationBar.rightBarButtonItem = toMap ? nextButton : nil; 
}

@end
