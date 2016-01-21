//
//  FirstViewCell.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/22.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "FirstViewCell.h"

@implementation FirstViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageView.image = [UIImage imageNamed:@"close"];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
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
