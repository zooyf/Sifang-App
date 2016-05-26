//
//  NSMutableParagraphStyle+Extension.m
//  BossZP
//
//  Created by 于洋 on 15/12/22.
//  Copyright © 2015年 com.dlnu.*. All rights reserved.
//

#import "NSMutableParagraphStyle+Extension.h"

@implementation NSMutableParagraphStyle (Extension)

- (id)initWithLineBreakMode:(NSLineBreakMode)lineBreakMode {
    if (self = [super init]) {
        self.lineBreakMode = lineBreakMode;
    }
    return self;
}

- (id)initWithLineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment {
    if (self = [super init]) {
        self.lineBreakMode = lineBreakMode;
        self.alignment = alignment;
    }
    return self;
}

@end
