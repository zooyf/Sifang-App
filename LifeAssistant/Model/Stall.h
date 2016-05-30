//
//  Stall.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/28.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "AVBaseModel.h"
#import "Restaurant.h"

@interface Stall : AVBaseModel

@property(nonatomic, strong) NSString       *phone;
@property(nonatomic, strong) NSString       *name;
@property(nonatomic, strong) NSString       *image_url;
@property(nonatomic, strong) NSString       *major_business;
@property(nonatomic, strong) NSNumber       *number;
@property(nonatomic, strong) NSString       *address;
@property(nonatomic, strong) Restaurant     *restaurant;

@end
