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

@synthesize loadedDelegate;
@synthesize coffeeResponseData;

NSString* const MAPURL = @"http://maps.google.co.uk/maps/ms?ie=UTF8&hl=en&msa=0&output=georss&msid=101901681374445814721.00046d3c1ee801655a44c";

- (id)init {
	[super init];
	coffeeResponseData = [[NSMutableData data]retain];
	coffeeShops = [[NSMutableArray alloc]init];
	return self;
}

- (void) findAll:(id<CoffeeShopRepositoryDelegate>) delegate {
	NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString:MAPURL] ];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
	self.loadedDelegate = delegate;	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [coffeeResponseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[connection release];
	
	NSString* responseString = [[NSString alloc] initWithData:coffeeResponseData encoding:NSUTF8StringEncoding];
	
	GDataXMLDocument* xmlDoc = [[GDataXMLDocument alloc]initWithXMLString:responseString options:0 error:0];
	
	NSArray* pointNodes = [xmlDoc nodesForXPath: @"/rss/channel/item" error:0];
	
	for (int i = 0; i < pointNodes.count; i++) {
		GDataXMLNode *coffeeShopXML = [pointNodes objectAtIndex:i];
		
		CoffeeShop* coffeeShop = [[CoffeeShop alloc] init];
		
		for (int j = 0; j < coffeeShopXML.children.count; j++) {
			GDataXMLNode *coffeeShopNodeXML = [coffeeShopXML.children objectAtIndex:j];
			
			if (![coffeeShopNodeXML.name compare:@"title"]) {
				coffeeShop.name = [coffeeShopNodeXML stringValue];
			}
			
			if (![coffeeShopNodeXML.name compare:@"georss:point"]) {
				
				NSString* point = [coffeeShopNodeXML stringValue];
				point = [point stringByReplacingOccurrencesOfString:@"  " withString:@""];
				point = [point stringByReplacingOccurrencesOfString:@"\n" withString:@""];
				
				NSArray* latitudeLongitude = [point componentsSeparatedByString:@" "];
				NSString* longitude = [latitudeLongitude objectAtIndex:0];
				NSString* latitude = [latitudeLongitude objectAtIndex:1];
				
				coffeeShop.location = [[CLLocation alloc]initWithLatitude:[longitude doubleValue] longitude:[latitude doubleValue] ];
			}
		}
		
		[coffeeShops addObject:coffeeShop];
	}
	
	if (self.loadedDelegate != NULL && [self.loadedDelegate respondsToSelector:@selector(shopsLoaded:)]) {
		[loadedDelegate shopsLoaded:coffeeShops];
	}  
}

- (NSMutableArray*) findAll {
	return coffeeShops;
};

@end
