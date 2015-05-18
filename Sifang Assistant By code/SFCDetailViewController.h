//
//  SFCDetailViewController.h
//  Sifang Assistant By code
//
//  Created by YesterdayFinder on 15/5/18.
//  Copyright (c) 2015年 YesterdayFinder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFCCourses.h"

typedef enum
{
    knumberofrow = 4,
    
    kmoreing = 0,
    knoon = 1,
    kafternoon = 2,
    kevening = 3,
    
    klabel = 9999
};

@interface SFCDetailViewController : UITableViewController

@property (retain , nonatomic) NSArray *labelArray;
@property (retain , nonatomic) NSMutableDictionary *tempValue;
@property (retain , nonatomic) UITextField *textFields;
@property (retain , nonatomic) SFCCourses *courseInfo;

@end
