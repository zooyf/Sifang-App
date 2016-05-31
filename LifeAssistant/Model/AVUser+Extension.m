//
//  AVUser+Extension.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/28.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "AVUser+Extension.h"

@implementation AVUser (Extension)

- (void)setName:(NSString *)name {
    [self setObject:name forKey:@"name"];
}
- (NSString *)name {
    return [self objectForKey:@"name"];
}

- (void)setDepartment:(NSString *)department {
    [self setObject:department forKey:@"department"];
}
- (NSString *)department {
    return [self objectForKey:@"department"];
}

- (void)setGrade:(NSString *)grade {
    [self setObject:grade forKey:@"grade"];
}
- (NSString *)grade {
    return [self objectForKey:@"grade"];
}

- (void)setAvatar:(AVFile *)avatarFile {
    [self setObject:avatarFile forKey:@"avatar"];
}
- (AVFile *)avatar {
    return [self objectForKey:@"avatar"];
}

- (void)setQQNumber:(NSString *)qq {
    [self setObject:qq forKey:@"qqNumber"];
}
- (NSString *)qqNumber {
    return [self objectForKey:@"qqNumber"];
}

@end
