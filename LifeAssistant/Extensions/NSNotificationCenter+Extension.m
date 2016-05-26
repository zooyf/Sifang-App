//
//  NSNotificationCenter+Extension.m
//  iOSShare
//
//  Created by wujin on 13-11-13.
//  Copyright (c) 2013年 wujin. All rights reserved.
//

#import "NSNotificationCenter+Extension.h"

@implementation NSNotificationCenter (Extension)
-(void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo onMainThread:(BOOL)onMainThread
{
    __weak __typeof(self)weakSelf = self;
	if(onMainThread){
		dispatch_async(dispatch_get_main_queue(), ^{
			[weakSelf postNotificationName:aName object:anObject userInfo:aUserInfo];
		});
	}else{
		[self postNotificationName:aName object:anObject userInfo:aUserInfo];
	}
}

-(void)postNotificationName:(NSString *)aName object:(id)anObject onMainThread:(BOOL)onMainThread

{
	[self postNotificationName:aName object:anObject userInfo:nil onMainThread:onMainThread];
}
@end
