//
//  FirstViewController.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 05/02/2010.
//  Copyright Black Art Studios 2010. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
	[super initWithCoder:aDecoder];
	lock = [[NSLock alloc]init];
	locationManager = [[CLLocationManager alloc] init];
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	isGettingCoffee = false;
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
	locationManager.distanceFilter = 1; // or whatever
	[locationManager startUpdatingLocation];
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

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	[lock lock];
	if (newLocation.horizontalAccuracy < 500 && !isGettingCoffee) {
		isGettingCoffee = true;
		[locationManager stopUpdatingLocation];
		[coffeeMap showUserLocation];
		[coffeeMap loadCoffeeShops];
	}
	[lock unlock];
}

@end
