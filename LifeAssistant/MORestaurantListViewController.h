//
//  MORestaurantListViewController.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/1.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "BaseViewController.h"

@class Restaurant;

@interface MORestaurantListViewController : BaseViewController

@property(nonatomic, copy) void(^selectionBlock)(Restaurant *restaurant);
@property(nonatomic, assign) BOOL forceSelect;

@end
