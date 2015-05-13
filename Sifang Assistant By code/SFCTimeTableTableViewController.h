//
//  SFCTimeTableTableViewController.h
//  Sifang Assistant By code
//
//  Created by YesterdayFinder on 15/5/12.
//  Copyright (c) 2015年 YesterdayFinder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassFIeld.h"

@interface SFCTimeTableTableViewController : UITableViewController

@property (retain , nonatomic) NSArray *controllers;


//

@property (retain , nonatomic) NSArray *fieldLabel;
@property (retain , nonatomic) NSMutableDictionary *tempValue;
@property (retain , nonatomic) UITextField *textFields;
@property (retain , nonatomic) ClassFIeld *classField;
//
@end
