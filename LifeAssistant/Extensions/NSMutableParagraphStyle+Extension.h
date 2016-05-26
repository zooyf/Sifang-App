//
//  NSMutableParagraphStyle+Extension.h
//  BossZP
//
//  Created by 于洋 on 15/12/22.
//  Copyright © 2015年 com.dlnu.*. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableParagraphStyle (Extension)

- (id)initWithLineBreakMode:(NSLineBreakMode)lineBreakMode;
- (id)initWithLineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment;

@end
