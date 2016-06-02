//
//  AppConfig.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/26.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"

@interface AppConfig : NSObject

+ (BOOL)checkBaseInfo;

/**
 *  返回所有分类信息
 *
 *  @return NSArray. include NSString Objects.
 */
+ (NSArray *)allKind;

/**
 *  检查当前用户是否是管理员用户
 *
 *  @return YES:是; NO:否.
 */
+ (BOOL)isManagerUser;

/**
 *  缓存当前餐厅
 *
 *  @param restaurant 当前餐厅对象
 */
+ (void)setCurrentRestaurant:(Restaurant *)restaurant;
/**
 *  获取缓存餐厅
 *
 *  @return 缓存的餐厅对象
 */
+ (Restaurant *)currentRestaurant;

/**
 *  退出登录
 */
+ (void)logout;

@end
