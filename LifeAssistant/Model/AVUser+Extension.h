//
//  AVUser+Extension.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/28.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "AVUser.h"

@interface AVUser (Extension)

- (void)setName:(NSString *)name;
- (NSString *)name;

- (void)setGrade:(NSString *)grade;
- (NSString *)grade;

- (void)setAvatar:(AVFile *)avatarFile;
- (AVFile *)avatar;

@end
