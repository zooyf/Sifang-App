//
//  SinglePickerView.h
//  BossZP
//
//  Created by yuyang on 15/8/31.
//  Copyright (c) 2015年 com.dlnu.*. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseItem.h"

@interface SinglePickerView : UIView

@property (nonatomic,strong) NSArray * aryItems;
@property (nonatomic,strong) NSString * title;
@property (nonatomic)        NSInteger selectedIndex;

@property (nonatomic,copy) void(^sureHandler)(id sender);
@property (nonatomic,copy) void(^cancelHandler)(id sender);

- (void)show;
- (void)closeAction;

@end
