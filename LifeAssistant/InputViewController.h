//
//  InputViewController.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/29.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "BaseViewController.h"

@interface InputViewController : BaseViewController
///点击右上角执行的操作，compleBlock在延时操作结束后pop需求时候执行
@property (nonatomic, copy) void(^rightActionBlock)(NSString * text);
@property (nonatomic, strong) NSString      * placeHolder;
///修改时传入的值，不传默认为空
@property (nonatomic, strong) NSString      * stringContent;
///点返回时提示语
@property (nonatomic,strong) NSString *backAlertStr;//当用户填写后 提示用户返回回去会有问题(多行)
//点保存时提示语
@property (nonatomic,strong) NSString *saveAlertStr;//传入时候，会在保存时候弹出alert提醒用户
///是否可以为空
@property (nonatomic) BOOL  canEmpty;


@end
