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
#import "LoadingView.h"
#import "CoffeeShopView.h"
#import "CoffeeShopMapAnnotation.h"

@interface MainViewController : UIViewController{
	IBOutlet CoffeeShopMap *coffeeMap;
	IBOutlet LoadingView *loadingView;
	IBOutlet CoffeeShopView *coffeeShopView;
	
	IBOutlet UINavigationItem *navigationBar;
	IBOutlet UIBarButtonItem *nextButton;
	IBOutlet UIBarButtonItem *listButton;
}

- (IBAction) nextButtonClicked:(id)sender;
- (IBAction) flipButtonClicked:(id)sender;
- (IBAction) directionsButtonClicked:(id)sender;
- (IBAction) hideButtonClicked:(id)sender;
- (void) locationUpdated;
- (void) shopsLoaded;
- (void) selectedMapAnnotationChanged:(CoffeeShopMapAnnotation*)annotation;
- (void) mapAnnotationSelected:(CoffeeShopMapAnnotation*)annotation;

@end
