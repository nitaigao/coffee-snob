//
//  CoffeeSnobAppDelegate.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 05/02/2010.
//  Copyright Black Art Studios 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoffeeSnobAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UIViewController *startViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *startViewController;

@end
