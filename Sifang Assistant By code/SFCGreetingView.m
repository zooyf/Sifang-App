//
//  SFCGreetingView.m
//  Sifang Assistant By code
//
//  Created by YesterdayFinder on 15/5/5.
//  Copyright (c) 2015年 YesterdayFinder. All rights reserved.
//

#import "SFCGreetingView.h"

@implementation SFCGreetingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
//- (void)drawRect:(CGRect)rect
//{
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window addSubview:button];
//    
//}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All BNRHypnosisViews start with a clear background color
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end
