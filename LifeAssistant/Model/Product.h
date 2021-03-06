//
//  Product.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/27.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "AVBaseModel.h"

#define kAVProductName @"Product"

typedef enum : NSUInteger {
    //下架
    ProductStatusOffSale = 0,
    //在售
    ProductStatusOnSale,
    //售出
    ProductStatusSoldOut,
} ProductStatus;

@interface Product : AVBaseModel

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *phone_num;
@property(nonatomic, strong) NSString *imageUrl;
@property(nonatomic, strong) NSString *qq;
@property(nonatomic, strong) NSString *describe;
@property(nonatomic, strong) NSString *price;
@property(nonatomic, strong) NSString *deal_location;
@property(nonatomic, strong) NSNumber *kind;
@property(nonatomic, assign) NSNumber *saleStatus;

@property(nonatomic, strong) AVUser *seller;

@end
