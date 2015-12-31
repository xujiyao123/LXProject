//
//  CellAutoLayoutCell.m
//  Project_iOS
//
//  Created by 刘旭 on 15/12/30.
//  Copyright © 2015年 刘旭. All rights reserved.
//

#import "CellAutoLayoutCell.h"
#import "UIView+SDAutoLayout.h"

@interface CellAutoLayoutCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation CellAutoLayoutCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.bgView = [UIView new];
        [self.contentView addSubview:self.bgView];
        
        self.titleLabel = [UILabel new];
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [UILabel new];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (void)setModel:(AutoLayoutModel *)model {
    
    _model = model;
    
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    
    _titleLabel.text = _model.title;
    _titleLabel.textColor = kAppTextColor;
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.sd_layout
    .topSpaceToView(self.contentView, 20)
    .leftSpaceToView(self.contentView, 10)
    .heightIs(12);
    [_titleLabel setSigleLineAutoResizeWithMaxWidth:200];
    
    _contentLabel.text = _model.content;
    _contentLabel.textColor = kAppTextColor;
    _contentLabel.font = [UIFont systemFontOfSize:12];
//    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:_contentLabel.text];
//    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
//    [para setLineSpacing:10];
//    [attributeString addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, _contentLabel.text.length)];
//    _contentLabel.numberOfLines = 0;
//    _contentLabel.attributedText = attributeString;
    _contentLabel.sd_layout
    .autoHeightRatio(0)
    .topSpaceToView(self.titleLabel, 10)
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10);
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
