//
//  MOFoodListViewController.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/1.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "BaseViewController.h"
#import "Stall.h"

@interface MOFoodListCell : UITableViewCell

@end


@interface MOFoodListViewController : BaseViewController

@property(nonatomic, strong) Stall *stall;
@property(nonatomic, copy) void(^doneBlock)();

@property(nonatomic, assign) BOOL afterAddNewStall;

@end
