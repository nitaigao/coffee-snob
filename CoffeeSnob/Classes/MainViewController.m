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

NSString* const MAP = @"Map";
NSString* const LIST = @"List";

- (id)initWithCoder:(NSCoder *)aDecoder {
	[super initWithCoder:aDecoder];
	coffeeShopRepository = [[CoffeeShopRepository alloc] init];	
	coffeeShopList = [[CoffeeShopList alloc] init];
	return self;
}

- (void)dealloc {
	[super dealloc];
	[coffeeShopRepository release];
	[coffeeShopList release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[loadingView startAnimating:@"Finding you..."];
	[coffeeMap startUpdatingLocation];
}

- (void)locationUpdated {
	[loadingView setMessage:@"Finding coffee..."];
	[coffeeShopRepository findAll:self fromUserLocation:[coffeeMap getUserLocation]];			
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
	[coffeeShopList addCoffeeShops:shops userLocation:[coffeeMap getUserLocation]];
	[coffeeMap shopsLoaded:coffeeShopList];
	[coffeeShopTableDataSource shopsLoaded:coffeeShopList delegate:self]; 
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
		CoffeeShop* coffeeShop = (CoffeeShop*)context;
	[coffeeMap selectShop:coffeeShop];
}

- (IBAction) flipToMap:(CoffeeShop*)coffeeShop {
	[UIView beginAnimations:nil context:coffeeShop];
	[UIView setAnimationDuration:.75];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[self view] cache:YES];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	[self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
	[UIView commitAnimations];
	listButton.title = LIST;
	navigationBar.rightBarButtonItem = nextButton;
}

- (void) listItemSelected:(CoffeeShop*)coffeeShop {
	[self flipToMap:coffeeShop];
}

- (void)flipViews:(UIViewAnimationTransition) transition {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationTransition:transition forView:[self view] cache:YES];
	[self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
	[UIView commitAnimations];
}

- (IBAction) flipButtonClicked:(id)sender {
	bool isList = ![listButton.title compare:LIST];
	[self flipViews:isList ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft];
	listButton.title = isList ? MAP : LIST;
	navigationBar.rightBarButtonItem = isList ? nil : nextButton; 
}

@end
