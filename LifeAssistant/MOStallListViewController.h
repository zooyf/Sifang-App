//
//  MOStallListViewController.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/1.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "BaseViewController.h"
#import <MJRefresh.h>

@interface MOStallListViewController : BaseViewController

/**
 *  判断是否是点击收藏进来的
 */
@property(nonatomic, assign) BOOL favourite;

@property(nonatomic, strong) Restaurant *currentRestaurant;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
