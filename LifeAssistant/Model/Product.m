//
//  Product.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/27.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "Product.h"

@implementation Product

@dynamic title;
@dynamic phone_num;
@dynamic imageUrl;
@dynamic qq;
@dynamic describe;
@dynamic price;
@dynamic deal_location;
@dynamic seller;
@dynamic kind;
@dynamic saleStatus;

+ (NSString *)parseClassName {
    return NSStringFromClass(self);
}

@end
