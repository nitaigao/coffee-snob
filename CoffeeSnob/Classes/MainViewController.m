//
//  FirstViewController.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 05/02/2010.
//  Copyright Black Art Studios 2010. All rights reserved.
//

#import "MainViewController.h"

#import <QuartzCore/QuartzCore.h>

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

- (void)coffeeShopSelected {
	[coffeeMap showDirectionsToSelectedCoffeeShop];
}

- (IBAction) nextButtonClicked:(id)sender {
	[coffeeMap showNextCoffeeShopToUser];
}

- (IBAction) flipButtonClicked:(id)sender {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationDuration:.75];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[self view] cache:YES];
	[self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
	[UIView commitAnimations];
	listButton.title = ![listButton.title compare:@"List"] ? @"Map" : @"List";
	navigationBar.rightBarButtonItem = ![listButton.title compare:@"List"] ? nextButton : nil; 
}

@end
