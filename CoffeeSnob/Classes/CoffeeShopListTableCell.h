//
//  CoffeeShopListTableCell.h
//  CoffeeSnob
//
//  Created by Nicholas Kostelnik on 08/03/2010.
//  Copyright 2010 Black Art Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoffeeShop.h"


@interface CoffeeShopListTableCell : UITableViewCell {
	id delegate;
}

- (void)setShop:(CoffeeShop*)shop delegate:(id)selectedDelegate;

@end
