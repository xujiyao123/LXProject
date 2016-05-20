//
//  LXCircleImageView.m
//  Project_iOS
//
//  Created by 美时美刻－01 on 16/5/20.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "LXCircleImageView.h"

@implementation LXCircleImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawImage {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [self.image drawInRect:CGRectMake(10, 10, rect.size.width - 10, rect.size.height - 10)];
}

@end
