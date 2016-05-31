//
//  Restaurant.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/28.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "AVBaseModel.h"

#define kRestaurantName @"Restaurant"

@interface Restaurant : AVBaseModel

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSNumber *rCode;
@end
