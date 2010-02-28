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
}

- (IBAction) nextButtonClicked:(id)sender;
- (void) locationUpdated;
- (void) shopsLoaded;

@end
