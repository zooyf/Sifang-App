//
//  RootViewController.h
//  课程表
//
//  Created by 雨 on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController //采用的是表视图控制器
<UITabBarControllerDelegate,UITabBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *controllers;
}

@property (retain , nonatomic) NSArray *controllers;

@end
