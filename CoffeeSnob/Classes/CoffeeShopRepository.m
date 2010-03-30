//
//  CoffeeShopRepository.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 06/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "CoffeeShopRepository.h"

#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocation.h>

#import "GDataXMLNode.h"

#import "CoffeeShop.h"

@implementation CoffeeShopRepository

NSString* const POINTNODEPATH = @"/rss/channel/item";

- (void)dealloc {
	[super dealloc];
	[userLocation release];
}

- (id)init {
	[super init];
	coffeeResponseData = [[NSMutableData data]retain];
	return self;
}

- (void) findAll:(id)delegate fromUserLocation:(CLLocation*)location {	
	NSString* shopsPath = [[NSBundle mainBundle] pathForResource:@"shops" ofType:@"xml"];	
	NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL fileURLWithPath:shopsPath]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self ];
	loadedDelegate = delegate;
	
	// eew - multithreading issues
	[userLocation release];
	userLocation = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
}

- (NSMutableArray *) createShopsFromPointNodes: (NSArray *) pointNodes  {
	NSMutableArray *results = [[[NSMutableArray alloc]init]autorelease];
	for (GDataXMLNode *coffeeShopNode in pointNodes) {
		CoffeeShop* coffeeShop = [[CoffeeShop alloc] initWithXml:coffeeShopNode andUserLocation:userLocation];
		[results addObject:coffeeShop];
	}
	return results;
}

- (NSMutableArray *) createShopsFromRSS: (NSString*) xmlString  {
	GDataXMLDocument* rssFeed = [[[GDataXMLDocument alloc]initWithXMLString:xmlString options:0 error:0]autorelease];
	NSArray* pointNodes = [rssFeed nodesForXPath:POINTNODEPATH error:0];
	return [self createShopsFromPointNodes: pointNodes];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"%@", error);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [coffeeResponseData appendData:data];
}

- (void)populateShops {
	NSString* responseString = [[[NSString alloc] initWithData:coffeeResponseData encoding:NSUTF8StringEncoding]autorelease];
	NSMutableArray *coffeeShops = [self createShopsFromRSS: responseString];
	if ([loadedDelegate respondsToSelector:@selector(shopsLoaded:)]) {
		[loadedDelegate performSelector:@selector(shopsLoaded:) withObject:coffeeShops];
	} 
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	[NSTimer scheduledTimerWithTimeInterval:1.0
									 target:self
								   selector:@selector(populateShops)
								   userInfo:nil
									repeats:NO];
	
	[connection release];	 
}



@end
