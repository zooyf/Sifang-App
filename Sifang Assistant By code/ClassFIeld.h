//
//  ClassFIeld.h
//  课程表
//
//  Created by 雨 on 12-11-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassFIeld : NSObject
{
    NSString *title;
    NSString *moreing;
    NSString *noon;
    NSString *afternoon;
    NSString *evening;
}

@property (retain , nonatomic) NSString *evening;
@property (retain , nonatomic) NSString *title;
@property (retain , nonatomic) NSString *moreing;
@property (retain, nonatomic) NSString *noon;
@property (retain ,nonatomic) NSString *afternoon;

- (void)setvalue;

@end
