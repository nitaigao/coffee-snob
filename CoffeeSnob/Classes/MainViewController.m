//
//  FirstViewController.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 05/02/2010.
//  Copyright Black Art Studios 2010. All rights reserved.
//

#import "MainViewController.h"

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

@end
