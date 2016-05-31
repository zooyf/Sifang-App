//
//  YFEasyHUD.h
//  BabyWatcher
//
//  Created by YesterdayFinder on 16/2/21.
//  Copyright © 2016年 Bruce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFEasyHUD : NSObject

+ (void)showIndicator;

+ (void)showIndicatorViewWithMsg:(NSString *)msg;

+ (void)showMsg:(NSString *)msg details:(NSString *)details lastTime:(NSTimeInterval)delay;

+ (void)showMsg:(NSString *)msg;

+ (void)hideHud;

@end
