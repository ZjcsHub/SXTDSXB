//
//  CollectionCell.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/25.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "CollectionCell.h"
#import "NSAttributedString+ZJCPriceString.h"
@interface CollectionCell ()

@property (nonatomic, strong)UIImageView * countryImage;    /** 国旗 */
@property (nonatomic, strong)UIImageView * goodsImage;    /** 商品图片 */
@property (nonatomic, strong)UILabel * goodsLabel;    /** 商品描述 */
@property (nonatomic, strong)UILabel * priceLabel;    /** 价格 */

@end

@implementation CollectionCell

- (void)setModel:(ZJCSearchModel *)model{
    _model = model;
    [_countryImage sd_setImageWithURL:[NSURL URLWithString:model.CountryImg]];
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:model.ImgView]];

    NSMutableParagraphStyle *paraga = [[NSMutableParagraphStyle alloc] init];
 
    paraga.firstLineHeadIndent =10;
    NSAttributedString * string =[[NSAttributedString alloc] initWithString:model.Title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSParagraphStyleAttributeName:paraga}];
    _goodsLabel.attributedText =string;
    _priceLabel.attributedText =[NSAttributedString returnFirstString:model.Price lastString:model.DomesticPrice];
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self.contentView addSubview:self.goodsImage];
        [self.contentView addSubview:self.countryImage];
        [self.contentView addSubview:self.goodsLabel];
        [self.contentView addSubview:self.priceLabel];
        self.backgroundColor =[UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakself =self;
    [_countryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(29, 22));
        make.top.left.equalTo(weakself.contentView).offset(10);
    }];
    [_goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakself.contentView);
        make.height.equalTo(@180);
    }];
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.goodsImage.mas_bottom);
        make.left.equalTo(weakself.contentView.mas_left).offset(11);
        make.right.equalTo(weakself.contentView.mas_right).offset(-11);
        make.height.equalTo(@50);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.goodsLabel.mas_bottom);
        make.left.right.bottom.equalTo(weakself.contentView);
    }];
}

- (UIImageView *)countryImage{
    if (!_countryImage) {
        _countryImage =[[UIImageView alloc] init];
    }
    return _countryImage;
}

- (UIImageView *)goodsImage{
    if (!_goodsImage) {
        _goodsImage =[[UIImageView alloc] init];
    }
    return _goodsImage;
}
- (UILabel *)goodsLabel{
    if (!_goodsLabel) {
        _goodsLabel =[[UILabel alloc] init];
        _goodsLabel.numberOfLines =0;
     
    }
    return _goodsLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel =[[UILabel alloc] init];
        _priceLabel.textAlignment =NSTextAlignmentCenter;
    }
    return _priceLabel;
}



@end
