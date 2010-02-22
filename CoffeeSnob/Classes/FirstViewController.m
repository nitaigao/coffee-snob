//
//  FirstViewController.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 05/02/2010.
//  Copyright Black Art Studios 2010. All rights reserved.
//

#import "FirstViewController.h"

#import <Foundation/Foundation.h>

#import "GDataXMLNode.h"
#import "JSON/JSON.h"

#import "CoffeeShopAnnotation.h"
#import "CoffeeShop.h"

@implementation FirstViewController

@synthesize coffeeShopRepository;

@synthesize locationManager;
@synthesize currentLocation;

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	
	NSLog( @"%d", newLocation.horizontalAccuracy );
	
	MKCoordinateRegion region;
	region.center = newLocation.coordinate;	//Set Zoom level using Span
	MKCoordinateSpan span;
	span.latitudeDelta = .005;
	span.longitudeDelta = .005;
	region.span = span;
	
	[coffeeView setRegion:region animated:TRUE];
	
	coffeeView.showsUserLocation = YES;
	
	//NSURL *url = [NSURL URLWithString:@"http://maps.google.co.uk/maps/ms?ie=UTF8&hl=en&vps=6&jsv=202c&msa=0&output=georss&msid=114353289294947720044.00047eff935bbb8a92738"];
	//NSURL *url = [NSURL URLWithString:@"http://maps.google.co.uk/maps/ms?ie=UTF8&hl=en&msa=0&output=georss&msid=101901681374445814721.00046d3c1ee801655a44c"];
	//self.coffeeShopRepository = [[CoffeeShopRepository alloc]initFromURL:url withDelegate:self];
		
}

-(void)shopsLoaded:(NSMutableArray *)coffeeShops {
	
	NSMutableArray* sortedShops = [[NSMutableArray alloc]init];
	NSMutableDictionary* coffeeShopsWithDistance = [[NSMutableDictionary alloc]init];
	
	for (int i = 0; i < coffeeShops.count; i++) {
		
		CoffeeShop* coffeeShop = [coffeeShops objectAtIndex:i];
		
		CLLocation* userLocation = [[CLLocation alloc]initWithLatitude:coffeeView.userLocation.coordinate.latitude longitude:coffeeView.userLocation.coordinate.longitude];
		double distanceFromUser = [coffeeShop.coordinate getDistanceFrom:userLocation];
		
		if (distanceFromUser < 0 ) {
			distanceFromUser = distanceFromUser * -1;
		}
		
		NSNumber* absoluteDistanceFromUser = [[NSNumber alloc]initWithDouble: distanceFromUser];
		NSString* absoluteDistanceFromUserString = [NSString stringWithFormat:@"%f", absoluteDistanceFromUser];
		
		[coffeeShopsWithDistance setValue:coffeeShop forKey:absoluteDistanceFromUserString];
		[sortedShops addObject:absoluteDistanceFromUser];	
	}
	
	[sortedShops sortUsingSelector:@selector(compare:)];
	
	for (int i = 0; i < coffeeShops.count; i++) {
		NSLog(@"%@", [sortedShops objectAtIndex:i]);
	}
	
	NSNumber* bestCoffeeShopKey = [sortedShops objectAtIndex:0];
	NSString* bestCoffeeShopKeyString = [NSString stringWithFormat:@"%f", bestCoffeeShopKey];
	CoffeeShop* bestCoffeeShop = [coffeeShopsWithDistance objectForKey:bestCoffeeShopKeyString];
	
	CoffeeShopAnnotation* coffeeShopAnnotation = [[CoffeeShopAnnotation alloc]init];
	coffeeShopAnnotation.coffeeShop = bestCoffeeShop;
	coffeeShopAnnotation.coordinate = bestCoffeeShop.coordinate.coordinate;
	[coffeeView addAnnotation:coffeeShopAnnotation];
	[[coffeeView viewForAnnotation:coffeeShopAnnotation]setSelected:TRUE animated:TRUE];
	
	double longitudeDifference = (bestCoffeeShop.coordinate.coordinate.longitude - coffeeView.userLocation.coordinate.longitude);
	double latitudeDifference = (bestCoffeeShop.coordinate.coordinate.latitude - coffeeView.userLocation.coordinate.latitude);
	
	double longitudeDefferenceMidpoint = longitudeDifference / 2;
	double latitudeDifferenceMidpoint = latitudeDifference / 2;
	
	double centerMapLongitude = coffeeView.userLocation.coordinate.longitude + longitudeDefferenceMidpoint;
	double centerMapLatitude = coffeeView.userLocation.coordinate.latitude + latitudeDifferenceMidpoint;
	
	CLLocation* centerMapLocation = [[CLLocation alloc]initWithLatitude:centerMapLatitude longitude:centerMapLongitude];
	
	MKCoordinateSpan span;
	span.latitudeDelta = (latitudeDifference > 0) ? latitudeDifference : -latitudeDifference;
	span.longitudeDelta = (longitudeDifference > 0) ? longitudeDifference : -longitudeDifference;
	
	MKCoordinateRegion region;
	region.center = centerMapLocation.coordinate;
	region.span = span;
	 
	[coffeeView setRegion:region animated:TRUE];
}

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;
	self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
	self.locationManager.distanceFilter = 1; // or whatever
	[self.locationManager startUpdatingLocation];

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
