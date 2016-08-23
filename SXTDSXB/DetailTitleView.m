//
//  DetailTitleView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/23.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "DetailTitleView.h"

@interface DetailTitleView ()
/**
 *  头上部的label
 */
@property (nonatomic,strong) UILabel * titlelabel;
/**
 *  价格属性label
 */
@property (nonatomic,strong) UILabel * pricelabel;
/**
 *  价格label下的黑线
 */
@property (nonatomic,strong) UILabel * pricelineLabel;
/**
 *  描述label
 */
@property (nonatomic,strong) UILabel * contentLabel;
/**
 *  下一步的大按钮
 */
@property (nonatomic,strong) UIButton * nextViewButton;
/**
 *  跳往下一步的小尖角图片
 */
@property (nonatomic,strong) UIImageView * nextviewImage;
/**
 * 商品名图片
 */
@property (nonatomic,strong) UIImageView * goodsImage;
/**
 *  商品名字
 */
@property (nonatomic, strong) UILabel * shopName;
/**
 *  国家名字
 */
@property (nonatomic, strong) UILabel * countrylabel;
/**
 *  国家图片
 */
@property (nonatomic, strong) UIImageView * countryicon;
/**
 *  跳往相同商品的label
 */
@property (nonatomic,strong) UILabel * sameGoodslabel;
/**
 *  大背景
 */
@property (nonatomic,strong) UIView * backgroundview;



@end

@implementation DetailTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        [self addSubview:self.titlelabel];
        [self addSubview:self.pricelabel];
        [self addSubview:self.pricelabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.backgroundview];
        [self addSubview:self.nextViewButton];
        [self addSubview:self.nextviewImage];
        [self addSubview:self.goodsImage];
        [self addSubview:self.shopName];
        [self addSubview:self.countryicon];
        [self addSubview:self.countrylabel];
        [self addSubview:self.sameGoodslabel];
        
        [self makelayoutSubviews];
    }
    return self;
}


- (void)makelayoutSubviews{
    __weak typeof (self) weakself =self;
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mas_top);
        make.right.equalTo(weakself.mas_right).offset(-15);
        make.left.equalTo(weakself.mas_left).offset(15);
    }];
    
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.titlelabel.mas_bottom).offset(25);
        make.left.right.equalTo(weakself);
        make.height.equalTo(@20);
    }];
    
    [_pricelineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-15);
        make.left.equalTo(weakself.mas_left).offset(15);
        make.height.equalTo(@1);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
    }];
}

- (UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel =[[UILabel alloc] init];
        _titlelabel.font =[UIFont systemFontOfSize:16];
    }
    return _titlelabel;
}

- (UILabel *)pricelabel{
    if (!_pricelabel) {
        _pricelabel =[[UILabel alloc] init];
    }
    return _pricelabel;
}

- (UILabel *)pricelineLabel{
    if (!_pricelineLabel) {
        _pricelineLabel =[[UILabel alloc] init];
    }
    return _pricelineLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel =[[UILabel alloc] init];
        _contentLabel.font =[UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}

- (UIView *)backgroundview{
    if (!_backgroundview) {
        _backgroundview = [[UIView alloc] init];
        _backgroundview.backgroundColor = MainColor;
    }
    return _backgroundview;
}

- (UIImageView *)nextviewImage{
    if (!_nextviewImage) {
        _nextviewImage =[[UIImageView alloc] init];
    }
    return _nextviewImage;
}

- (UIButton *)nextViewButton{
    if (!_nextViewButton) {
        _nextViewButton =[UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _nextViewButton;
}

- (UIImageView *)goodsImage{
    if (!_goodsImage) {
        _goodsImage =[[UIImageView alloc] init];
    }
    return _goodsImage;
}

- (UILabel *)shopName{
    if (!_shopName) {
        _shopName =[[UILabel alloc] init];
    }
    return _shopName;
}

- (UILabel *)countrylabel{
    if (!_countrylabel) {
        _contentLabel =[[UILabel alloc] init];
    }
    return _contentLabel;
}

- (UILabel *)sameGoodslabel{
    if (!_sameGoodslabel) {
        _sameGoodslabel =[[UILabel alloc] init];
    }
    return _sameGoodslabel;
}

- (UIImageView *)countryicon{
    if (!_countryicon) {
        _countryicon =[[UIImageView alloc] init];
    }
    return _countryicon;
}












@end
