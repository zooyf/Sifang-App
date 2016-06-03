//
//  YFMineInfoViewController.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/6/1.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "BaseTableViewController.h"

@interface MYInfoController : BaseTableViewController

/**
 *  退出登录的block
 */
@property(nonatomic, copy) void(^logoutBlock)();

/**
 *  selector 编辑按钮的方法
 */
@property(nonatomic, assign) SEL selEditAction;

/**
 *  注册后必须立刻完善信息
 */
@property(nonatomic, assign) BOOL afterReg;

@end
