//
//  LoadingView.m
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 28/02/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import "LoadingView.h"
#import <QuartzCore/QuartzCore.h>


@implementation LoadingView

- (void)startAnimating:(NSString*)initialMessage {
	hudView.layer.cornerRadius = 10.0;
	[activityIndicatorView startAnimating];
	[self setMessage:initialMessage];
}

- (void)setMessage:(NSString*)message {
	[captionLabel setText:message];
}

- (void)stopAnimatingAndHide {
	[activityIndicatorView stopAnimating];
	[self removeFromSuperview];
}

- (void)dealloc {
    [super dealloc];
}

@end
