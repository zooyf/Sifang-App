//
//  AppConfig.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/26.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig

+ (BOOL)checkBaseInfo {
    return [AVUser currentUser];
}

@end
