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

@end