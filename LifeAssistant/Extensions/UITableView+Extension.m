//
//  UITableView+Extension.m
//  BossZP
//
//  Created by 于洋 on 16/3/15.
//  Copyright © 2016年 com.dlnu.*. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

#pragma mark - 没有数据的空图
- (void)showEmptyContent {
    if (self.tableFooterView.tag==903232) {
        return;
    }
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100);
    view.backgroundColor = [UIColor clearColor];
    UIImageView * img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nocontent.png"]];
    img.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 100)/2.f, 35, 100, 47);
    [view addSubview:img];
    view.tag = 903232;
    self.tableFooterView = view;
}

- (void)hiddenEmptyContent {
    self.tableFooterView = [[UIView alloc] init];
}

@end
