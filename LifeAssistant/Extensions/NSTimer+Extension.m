//
//  NSTimer+Extension.m
//  BossZP
//
//  Created by mosn on 6/8/15.
//  Copyright (c) 2015 com.dlnu.*. All rights reserved.
//

#import "NSTimer+Extension.h"

@implementation NSTimer(Extension)

+(NSTimer *)clscheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(clblockInvoke:)userInfo:[block copy]repeats:repeats];
}

+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats
{
    void (^block)() = [inBlock copy];
    id ret = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(clblockInvoke:) userInfo:block repeats:inRepeats];
    return ret;
}

+(void)clblockInvoke:(NSTimer*)timer
{
    void(^block)()=timer.userInfo;
    if (block) {
        block();
    }
}

@end
