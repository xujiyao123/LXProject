//
//  CellAutoLayoutCell.h
//  Project_iOS
//
//  Created by 刘旭 on 15/12/30.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AutoLayoutModel.h"

@interface CellAutoLayoutCell : BaseTableViewCell

@property (nonatomic, strong) AutoLayoutModel *model;

- (void)setModel:(AutoLayoutModel *)model;

@end
