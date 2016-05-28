//
//  ChooseItem.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/28.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseItem : NSObject
@property (nonatomic)int code;
@property (nonatomic)int pCode;
@property (strong, nonatomic) NSString * name;

- (ChooseItem *)initWithCode:(int)code pCode:(int)pCode name:(NSString *)name;

- (ChooseItem *)initWithCode:(int)code name:(NSString *)name;

+ (ChooseItem *)itemWithCode:(int)code pCode:(int)pCode name:(NSString *)name;

+ (ChooseItem *)itemWithCode:(int)code name:(NSString *)name;

@end
