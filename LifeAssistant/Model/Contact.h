//
//  Contact.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/31.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "AVBaseModel.h"
#import "Department.h"

@interface Contact : AVBaseModel

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *phone;

@property(nonatomic, strong) Department *department;

@end
