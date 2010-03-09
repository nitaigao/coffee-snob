//
//  FirstViewController.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 05/02/2010.
//  Copyright Black Art Studios 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "CoffeeShopMap.h"
#import "CoffeeShopList.h"
#import "LoadingView.h"
#import "MapSummaryView.h"
#import "CoffeeShopMapAnnotation.h"

@interface MainViewController : UIViewController{
	IBOutlet CoffeeShopMap *coffeeMap;
	IBOutlet CoffeeShopList *coffeeList;
	IBOutlet LoadingView *loadingView;
	IBOutlet MapSummaryView *coffeeShopView;
	
	IBOutlet UINavigationItem *navigationBar;
	IBOutlet UIBarButtonItem *nextButton;
	IBOutlet UIBarButtonItem *listButton;
}

- (IBAction) nextButtonClicked:(id)sender;
- (IBAction) flipButtonClicked:(id)sender;
- (IBAction) directionsButtonClicked:(id)sender;
- (void) locationUpdated;
- (void) shopsLoaded;
- (void) selectedMapAnnotationChanged:(CoffeeShopMapAnnotation*)annotation;

@end
