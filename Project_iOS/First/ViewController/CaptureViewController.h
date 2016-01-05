//
//  CaptureViewController.h
//  ImagePickerDemo
//
//  Created by Ryan Tang on 13-1-5.
//  Copyright (c) 2013年 Ericsson Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGSimpleImageEditorView.h"

@protocol CaptureViewControllerDelegate <NSObject>

-(void)passImage:(UIImage *)image;

@end

@interface CaptureViewController : UIViewController

@property(nonatomic, strong) UIImage *image;

@property(nonatomic, weak) id<CaptureViewControllerDelegate> delegate;

@end