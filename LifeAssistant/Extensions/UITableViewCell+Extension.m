//
//  UITableViewCell+Separator.m
//  BossZP
//
//  Created by kanzhun on 16/4/1.
//  Copyright © 2016年 com.dlnu.*. All rights reserved.
//

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)

- (void)dealLineWithLeftInsert:(CGFloat)leftInsert {
    [self dealLineWithLeftInsert:leftInsert rightInsert:0];
}

- (void)dealLineWithLeftInsert:(CGFloat)leftInsert rightInsert:(CGFloat)rightInsert {
    if ([self respondsToSelector:@selector(setSeparatorInset:)])[self setSeparatorInset:UIEdgeInsetsMake(0, leftInsert, 0, rightInsert)];
#ifdef __IPHONE_8_0
    if ([self respondsToSelector:@selector(setLayoutMargins:)])[self setLayoutMargins:UIEdgeInsetsMake(0, leftInsert, 0, rightInsert)];
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])[self setPreservesSuperviewLayoutMargins:NO];
#endif
}

@end
