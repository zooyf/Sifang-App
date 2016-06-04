//
//  MarketClasification.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/6/3.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketClassification : AVBaseModel

@property(nonatomic, strong) NSString *category;
@property(nonatomic, strong) NSString *kind;
@property(nonatomic, strong) NSString *describe;

@property(nonatomic, strong) AVFile *image;

@end
