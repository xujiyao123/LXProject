//
//  DTouchDetailViewController.h
//  Project_iOS
//
//  Created by 刘旭 on 15/12/22.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "BaseViewController.h"

@protocol DTouchDetailViewControllerDelegate <NSObject>

- (void)returnResult:(NSInteger)count;

@end


@interface DTouchDetailViewController : BaseViewController

@property (nonatomic, strong) NSString *labelText;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, weak) id<DTouchDetailViewControllerDelegate> delegate;

@end
