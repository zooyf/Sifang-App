//
//  Food.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/31.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "Food.h"
#import "Stall.h"

@implementation Food

@dynamic name;
@dynamic price;
@dynamic order;
@dynamic stall;

+ (NSString *)parseClassName {
    return NSStringFromClass(self);
}

@end
