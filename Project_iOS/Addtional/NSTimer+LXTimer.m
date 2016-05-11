//
//  NSTimer+LXTimer.m
//  Project_iOS
//
//  Created by 刘旭 on 16/5/11.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "NSTimer+LXTimer.h"

@implementation NSTimer (LXTimer)

+ (NSTimer *)lx_scheduleTimerWithTimeInterval:(NSTimeInterval)interval
                                        block:(void(^)())block
                                      repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(lx_blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)lx_blockInvoke:(NSTimer *)timer {
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}

@end
