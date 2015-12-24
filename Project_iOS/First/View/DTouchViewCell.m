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
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageForKey:@"placeholder"];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
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
