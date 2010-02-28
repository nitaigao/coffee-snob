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

@interface MainViewController : UIViewController{
	IBOutlet CoffeeShopMap *coffeeMap;
	IBOutlet LoadingView *loadingView;
	
	IBOutlet UINavigationItem *navigationBar;
	IBOutlet UIBarButtonItem *nextButton;
	IBOutlet UIBarButtonItem *listButton;
	
	IBOutlet UIView *listView;
	IBOutlet UIView *mapView;
}

- (IBAction) nextButtonClicked:(id)sender;
- (IBAction) flipButtonClicked:(id)sender;
- (void) locationUpdated;
- (void) shopsLoaded;

@end
