//
//  CoffeeShopListTableCell.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 08/03/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CoffeeShopListTableCell : UITableViewCell {

	IBOutlet UIImageView *iconImage;
	IBOutlet UILabel *titleLabel;
	IBOutlet UILabel *distanceLabel;
	
}


- (void)setDetail:(NSString*)title imageUrl:(NSString*)imageUrl distance:(NSString*)distance;

@end
