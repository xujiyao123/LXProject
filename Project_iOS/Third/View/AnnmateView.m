//
//  AnnmateView.m
//  Project_iOS
//
//  Created by sunnytu on 16/4/25.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import "AnnmateView.h"
#import "UIView+Nib.h"
@interface AnnmateView()

@property (nonatomic ,retain) AnnsubView * bac;
@property (nonatomic ,assign) NSInteger openFlag;


@end

@implementation AnnmateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        AnnsubView * bac = [AnnsubView loadInstanceFromNib];
        bac.frame = CGRectMake(0, SCREEN_HEIGHT/2, 50, 50);
        bac.backgroundColor = [UIColor redColor];
        bac.layer.cornerRadius = 25;
        [bac showOrHiden];
        [self addSubview:bac];
 
        bac.ButtonAction = ^(UIButton * button , NSInteger index) {
            if (self.ButtonAction) {
                self.ButtonAction(button , index);
            }
        };
    
        self.openFlag = 0;
        self.bac = bac;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
        [tap addTarget:self action:@selector(tapAction:)];
        [bac addGestureRecognizer:tap];
        
        
        if (_duration == 0) {
            self.duration = 0.5;
        }
        
        
    }
    return self;
}
- (void)tapAction:(UITapGestureRecognizer *)tap {
    self.bac.alpha = 1;
   
    
    if (self.openFlag == 0) {
        [self open];
    }else {
        [self close];
    }

    
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        UITouch * touchObject = [touches anyObject];
    
    if ([touchObject.view isEqual:self.bac]) {
        
        self.bac.alpha = 1;
        
        if (self.openFlag == 1) {
            [self close];
        }
        
        
        
        self.bac.layer.position = [touchObject locationInView:self];
    }

    
    
  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
    
    UITouch * touch = [touches anyObject];
    if ([touch.view isEqual:self.bac]) {
        return;
    }
    
    if (self.openFlag == 1) {
         self.bac.alpha = 1;
        [self close];
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
       UITouch * touchObject = [touches anyObject];
    if ([touchObject.view isEqual:self.bac]) {
        
        
        CGPoint touchEndPoint = [touchObject locationInView:self];
        
        [self positionResite:touchEndPoint];
    }
    
    
    
    
}
- (void)positionResite:(CGPoint)touchEndPoint {
    if (touchEndPoint.x > SCREEN_WIDTH /2) {
        
        self.bac.layer.position = CGPointMake(SCREEN_WIDTH - 25 , touchEndPoint.y);
    }else {
        self.bac.layer.position = CGPointMake( 25, touchEndPoint.y);
    }
    
    
    if (self.bac.size.width == 50) {
        
        [NSTimer scheduledTimerWithTimeInterval:4 block:^(NSTimer * _Nonnull timer) {
            
            self.bac.alpha = 0.2;
            
            
        } repeats:NO];
    }
    
}



- (void)open {
    
    if (self.bac.layer.position.x == SCREEN_WIDTH - 25) {
        [UIView animateWithDuration:_duration animations:^{
             CGRect rect = self.bac.frame;
            rect.origin.x = SCREEN_WIDTH - 200;
            rect.size.width = 200;
            self.bac.frame = rect;
            self.openFlag = 1;
        }];
        
    }else {
        
        [UIView animateWithDuration:_duration animations:^{
            CGRect rect = self.bac.frame;
            rect.size.width = 200;
            self.bac.frame = rect;
            self.openFlag = 1;
        }];
    }

    
    [self.bac showOrHiden];
}

- (void)close {
    
    if (self.bac.frame.origin.x == SCREEN_WIDTH - 200) {
        
        [UIView animateWithDuration:_duration animations:^{
            CGRect rect = self.bac.frame;
            rect.origin.x = SCREEN_WIDTH - 50;
            rect.size.width = 50;
            self.bac.frame = rect;
            self.openFlag = 0;
        }];
        
        
    }else {
        [UIView animateWithDuration:_duration animations:^{
            CGRect rect = self.bac.frame;
            rect.size.width = 50;
            self.bac.frame = rect;
            self.openFlag = 0;
        }];
    }
    [self.bac showOrHiden];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



@interface AnnsubView()


@end

@implementation AnnsubView

- (void)awakeFromNib {
    
    self.button1.tag = 0;
    self.button2.tag = 1;
    self.button3.tag = 2;
    
}

-(void)showOrHiden {
    
    if (self.size.width == 50) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            
            
            
            CGRect rect = self.button1.frame;
            self.button2.frame = rect;
            self.button3.frame = rect;
            self.button2.hidden = YES;
            self.button1.hidden = YES;
            self.button3.hidden = YES;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }else {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            
            
            CGRect rect = self.button1.frame;
            self.button2.frame = CGRectMake(rect.origin.x + rect.size.width, rect.origin.y, rect.size.width, rect.size.height);
            
            CGRect rect2 = self.button2.frame;
            self.button3.frame = CGRectMake(rect2.origin.x + rect2.size.width, rect2.origin.y, rect2.size.width, rect2.size.height);
            
            self.button1.hidden = NO;
            self.button2.hidden = NO;
            self.button3.hidden = NO;
            
        } completion:^(BOOL finished) {
            
        }];
        
        
    }
    
    
    
}
- (IBAction)btnAction:(UIButton *)sender {
    
    if (self.ButtonAction) {
        self.ButtonAction(sender , sender.tag);
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end




