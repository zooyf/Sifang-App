//
//  AppConfig.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/26.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
