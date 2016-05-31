//
//  AVUser+Extension.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/28.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "AVUser.h"

@interface AVUser (Extension)

/**
 *  用户昵称. userName是账号
 *
 *  @param name 用户昵称
 */
- (void)setName:(NSString *)name;
- (NSString *)name;

/**
 *  设置系别
 *
 *  @param department 系别名称. e.g.计算机系
 */
- (void)setDepartment:(NSString *)department;
- (NSString *)department;

/**
 *  设置年级
 *
 *  @param grade 年级
 */
- (void)setGrade:(NSString *)grade;
- (NSString *)grade;

/**
 *  设置头像
 *
 *  @param avatarFile 头像
 */
- (void)setAvatar:(AVFile *)avatarFile;
- (AVFile *)avatar;

/**
 *  设置qq号
 *
 *  @param qq qq号
 */
- (void)setQQNumber:(NSString *)qq;
- (NSString *)qqNumber;

@end
