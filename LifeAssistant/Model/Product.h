//
//  Product.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/27.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "AVBaseModel.h"

@interface Product : AVBaseModel

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *phone_num;
@property(nonatomic, strong) NSString *imageUrl;
@property(nonatomic, strong) NSString *qq;
@property(nonatomic, strong) NSString *describe;
@property(nonatomic, strong) NSString *price;
@property(nonatomic, strong) NSString *deal_location;
@property(nonatomic, strong) NSString *seller;
@property(nonatomic, strong) NSNumber *kind;

@end
