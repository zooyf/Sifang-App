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

+ (NSArray *)allKind {
    return @[@"数码配件", @"数码", @"手机", @"电脑",
             @"校园代步", @"电器", @"运动健身", @"衣物伞冒",
             @"图书教材", @"租赁", @"生活娱乐", @"其他"];
}

+ (BOOL)isManagerUser {
    return [[[AVUser currentUser] objectForKey:@"manager"] boolValue];
}

+ (Restaurant *)currentRestaurant {
    NSDictionary *objDic = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentRestaurant];
    Restaurant *res = (Restaurant *)[Restaurant objectWithDictionary:objDic];
    return res;
}

+ (void)setCurrentRestaurant:(Restaurant *)restaurant {
    [[NSUserDefaults standardUserDefaults] setObject:[restaurant dictionaryForObject] forKey:kCurrentRestaurant];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
