//
//  ChooseItem.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/28.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "ChooseItem.h"

@implementation ChooseItem

- (ChooseItem *)initWithCode:(int)code pCode:(int)pCode name:(NSString *)name {
    if (self = [super init]) {
        self.code = code;
        self.pCode = pCode;
        self.name = name;
    }
    return self;
}

- (ChooseItem *)initWithCode:(int)code name:(NSString *)name {
    if (self = [super init]) {
        self.code = code;
        self.name = name;
    }
    return self;
}

+ (ChooseItem *)itemWithCode:(int)code pCode:(int)pCode name:(NSString *)name {
    return [[ChooseItem alloc] initWithCode:code pCode:pCode name:name];
}

+ (ChooseItem *)itemWithCode:(int)code name:(NSString *)name {
    return [[ChooseItem alloc] initWithCode:code name:name];
}

@end
