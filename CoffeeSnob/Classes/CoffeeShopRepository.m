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

NSString* const MAPURL = @"http://maps.google.co.uk/maps/ms?ie=UTF8&hl=en&msa=0&output=georss&msid=101901681374445814721.00046d3c1ee801655a44c";
NSString* const POINTNODEPATH = @"/rss/channel/item";

- (id)init {
	[super init];
	coffeeResponseData = [[NSMutableData data]retain];
	return self;
}

- (void) findAll:(id)delegate {
	NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString:MAPURL] ];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	loadedDelegate = delegate;	
}

- (NSMutableArray *) createShopsFromPointNodes: (NSArray *) pointNodes  {
	NSMutableArray *results = [[NSMutableArray alloc]init];
	for (GDataXMLNode *coffeeShopNode in pointNodes) {
		CoffeeShop* coffeeShop = [[CoffeeShop alloc] initWithXml:coffeeShopNode];
		[results addObject:coffeeShop];
	}
	return results;
}

- (NSMutableArray *) createShopsFromRSS: (NSString*) xmlString  {
	GDataXMLDocument* rssFeed = [[GDataXMLDocument alloc]initWithXMLString:xmlString options:0 error:0];
	NSArray* pointNodes = [rssFeed nodesForXPath:POINTNODEPATH error:0];
	return [self createShopsFromPointNodes: pointNodes];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [coffeeResponseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
	NSString* responseString = [[NSString alloc] initWithData:coffeeResponseData encoding:NSUTF8StringEncoding];
	NSMutableArray *coffeeShops = [self createShopsFromRSS: responseString];
	if ([loadedDelegate respondsToSelector:@selector(shopsLoaded:)]) {
		[loadedDelegate performSelector:@selector(shopsLoaded:) withObject:coffeeShops];
	}  
}


@end
