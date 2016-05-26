//
//  NSTimer+Extension.h
//  BossZP
//
//  Created by mosn on 6/8/15.
//  Copyright (c) 2015 com.dlnu.*. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer(Extension)

+(NSTimer *)clscheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeats:(BOOL)repeats;
+(NSTimer *)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;
@end
