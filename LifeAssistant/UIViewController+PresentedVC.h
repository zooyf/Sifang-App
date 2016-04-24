//
//  UIViewController+PresentedVC.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/24.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PresentedVC)

/**
 *  返回最顶层的视图控制器
 *
 *  @return 顶层视图控制器
 */
- (UIViewController*)topViewController;

@end

@interface UIApplication (PresentedVC)

/**
 *  返回最顶层的视图控制器
 *
 *  @return 顶层视图控制器
 */
- (UIViewController*)topViewController;

@end