//
//  LoadingView.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 28/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoadingView : UIView {
	IBOutlet UIView *hudView;
	IBOutlet UIActivityIndicatorView *activityIndicatorView;
	IBOutlet UILabel *captionLabel;
}

- (void)startAnimating:(NSString*)initialMessage;
- (void)setMessage:(NSString*)message;
- (void)stopAnimatingAndHide;

@end
