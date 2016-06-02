//
//  YFMineInfoViewController.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/6/1.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "BaseTableViewController.h"

@interface MYInfoController : BaseTableViewController

@property(nonatomic, copy) void(^logoutBlock)();

@property(nonatomic, assign) SEL selEditAction;

@end
