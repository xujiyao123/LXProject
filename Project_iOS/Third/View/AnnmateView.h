//
//  AnnmateView.h
//  Project_iOS
//
//  Created by sunnytu on 16/4/25.
//  Copyright © 2016年 刘旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnmateView : UIView

@property (nonatomic ,assign)NSTimeInterval duration;

@property (nonatomic ,copy) void(^ButtonAction)(UIButton * button , NSInteger index);

@end









@interface AnnsubView : UIView

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;

@property (nonatomic , copy) void(^ButtonAction)(UIButton * button , NSInteger index);
- (void)showOrHiden;
@end