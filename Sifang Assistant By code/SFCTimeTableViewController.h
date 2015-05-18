//
//  SFCTimetableViewController.h
//  Sifang Assistant By code
//
//  Created by YesterdayFinder on 15/5/18.
//  Copyright (c) 2015年 YesterdayFinder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFCCourses.h"

@interface SFCTimeTableViewController : UITableViewController

@property (retain , nonatomic) NSArray *controllers;

@property (retain , nonatomic) NSArray *labelArray;
@property (retain , nonatomic) NSMutableDictionary *tempValue;
@property (retain , nonatomic) UITextField *textFields;
@property (retain , nonatomic) SFCCourses *course;

@end
