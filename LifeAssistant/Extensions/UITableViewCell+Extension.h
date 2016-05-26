//
//  UITableViewCell+Separator.h
//  BossZP
//
//  Created by kanzhun on 16/4/1.
//  Copyright © 2016年 com.dlnu.*. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Extension)

- (void)dealLineWithLeftInsert:(CGFloat)leftInsert;
- (void)dealLineWithLeftInsert:(CGFloat)leftInsert rightInsert:(CGFloat)rightInsert;

@end
