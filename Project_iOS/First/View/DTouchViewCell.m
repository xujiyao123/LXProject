//
//  DTouchViewCell.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/25.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "DTouchViewCell.h"

@implementation DTouchViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.label = [UILabel new];
        self.label.textColor = [UIColor blackColor];
        self.label.font = [UIFont lantingFontOfSize:30];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
