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
	[loadingView startAnimating:@"Finding you..."];
	[coffeeMap startUpdatingLocation];
}

- (void)locationUpdated {
	[coffeeMap showUserLocation];
	[loadingView setMessage:@"Finding coffee..."];
	[[[CoffeeShopRepository alloc] init] findAll:self];			
}

- (void)shopsLoaded {
	[loadingView stopAnimatingAndHide];
	[navigationBar setRightBarButtonItem:nextButton];
	[navigationBar setLeftBarButtonItem:listButton];
}

- (void) selectedMapAnnotationChanged:(CoffeeShopMapAnnotation*)annotation {
	[coffeeShopView setAnnotation: annotation];
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

- (IBAction) nextButtonClicked:(id)sender {
	[coffeeMap showNextCoffeeShopToUser];
}

- (void)shopsLoaded:(NSMutableArray *)shops {
	[loadingView stopAnimatingAndHide];
	[navigationBar setRightBarButtonItem:nextButton];
	[navigationBar setLeftBarButtonItem:listButton];
	[coffeeMap shopsLoaded:shops];
	[coffeeList shopsLoaded:shops]; 
}

- (void)flipViews:(UIViewAnimationTransition) transition {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationDuration:.75];
	[UIView setAnimationTransition:transition forView:[self view] cache:YES];
	[self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
	[UIView commitAnimations];
}

- (IBAction) flipButtonClicked:(id)sender {
	bool isList = ![listButton.title compare:@"List"];
	isList && coffeeShopView.hidden == FALSE ? [coffeeShopView removeFromSuperview] : [self.view addSubview:coffeeShopView];
	[self flipViews:isList ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft];
	listButton.title = isList ? @"Map" : @"List";
	navigationBar.rightBarButtonItem = isList ? nil : nextButton; 
}

@end
