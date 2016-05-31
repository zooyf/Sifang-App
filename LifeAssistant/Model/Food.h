//
//  Food.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/31.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "AVBaseModel.h"
@class Stall;

@interface Food : AVBaseModel

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSNumber *price;
@property(nonatomic, strong) NSNumber *order;

@property(nonatomic, strong) Stall *stall;

@end
