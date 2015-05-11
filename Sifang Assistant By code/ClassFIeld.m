//
//  ClassFIeld.m
//  课程表
//
//  Created by 雨 on 12-11-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ClassFIeld.h"

@implementation ClassFIeld

@synthesize evening;
@synthesize noon;
@synthesize afternoon;
@synthesize moreing;
@synthesize title;

- (void)setvalue
{
    self.evening = [[NSString alloc] init];
    self.title = [[NSString alloc] init];
    self.noon = [[NSString alloc] init];
    self.moreing = [[NSString alloc] init];
    self.afternoon = [[NSString alloc] init];
}

- (void)dealloc
{
    [noon release];
    [moreing release];
    [afternoon release];
    [title release];
    [evening release];
    [super dealloc];
}

@end
