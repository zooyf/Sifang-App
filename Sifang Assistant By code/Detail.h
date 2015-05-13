//
//  Detail.h
//  课程表
//
//  Created by 雨 on 12-11-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassFIeld.h"

#define knumberofrow 4
#define kmoreing 0
#define knoon 1
#define kafternoon 2
#define kevening 3

#define klabel 9999

@interface Detail : UITableViewController
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSArray *fieldLabel;
    NSMutableDictionary *tempValue;
    UITextField *textFields;
    ClassFIeld *classField;
}

@property (retain , nonatomic) NSArray *fieldLabelArray;
@property (retain , nonatomic) NSMutableDictionary *tempValue;
@property (retain , nonatomic) UITextField *textFields;
@property (retain , nonatomic) ClassFIeld *classField;

@end
