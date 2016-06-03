//
//  YFUtils.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/27.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFUtils : NSObject

/**
 *  顶层控制器
 *
 *  @return 返回当前正在显示的控制器
 */
+ (UIViewController *)topController;

/**
 *  顶层视图
 *
 *  @return 返回当前最顶层的视图
 */
+ (UIView *)topView;

+ (UIViewController *)infoController;

@end
