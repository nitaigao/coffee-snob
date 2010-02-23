//
//  FirstViewController.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 05/02/2010.
//  Copyright Black Art Studios 2010. All rights reserved.
//

#import "MainViewController.h"
#import "CoffeeShopAnnotation.h"
#import "CoffeeShop.h"

@implementation MainViewController

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
	[coffeeMap setController:self];
}


- (void)showCoffeeShopDetails:(NSString*)title {
	NSLog(@"%@", title);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	
	[lock lock];
	if (newLocation.horizontalAccuracy < 500 && !isGettingCoffee) {
		isGettingCoffee = true;
		[locationManager stopUpdatingLocation];
		[coffeeMap showUserLocation];
		[[[CoffeeShopRepository alloc] init] findAll:self];			
	}
	[lock unlock];
}

-(void)shopsLoaded:(NSMutableArray *)coffeeShops {
	
	[coffeeMap addCoffeeShops:coffeeShops];
	[coffeeMap showClosestToUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}


- (void)dealloc {
    [super dealloc];
}

@end
