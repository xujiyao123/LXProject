//
//  NSTimer+LXTimer.h
//  Project_iOS
//
//  Created by 刘旭 on 16/5/11.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (LXTimer)

+ (NSTimer *)lx_scheduleTimerWithTimeInterval:(NSTimeInterval)interval
                                        block:(void(^)())block
                                      repeats:(BOOL)repeats;

@end
