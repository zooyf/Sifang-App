//
//  FMListCell.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/19.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

#define kFMListCell @"FMListCell"

@interface FMListCell : UITableViewCell

@property(nonatomic, strong) Product *product;

@end
