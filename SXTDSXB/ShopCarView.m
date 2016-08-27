//
//  ShopCarView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/27.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ShopCarView.h"

@interface ShopCarView ()

@property (nonatomic, strong)UIImageView * shouCarImage;    /** 购物车图片 */

@property (nonatomic, strong)UILabel * decripLabel;    /** 描述label */

@property (nonatomic, strong)UIButton * buyButton;    /** 去逛逛 */
@end

@implementation ShopCarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.shouCarImage];
        [self addSubview:self.decripLabel];
        [self addSubview:self.buyButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakself =self;
    [_shouCarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 150));
        make.top.equalTo(weakself.mas_top).offset(100);
        make.centerX.equalTo(weakself.mas_centerX);
    }];
    [_decripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.shouCarImage.mas_bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(@19);
    }];
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(115, 36));
        make.top.equalTo(weakself.decripLabel.mas_bottom).offset(15);
        make.centerX.equalTo(weakself.mas_centerX);
    }];
}


- (UIImageView *)shouCarImage{
    if (!_shouCarImage) {
        _shouCarImage =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"购物车界面静态购物车图标"]];
    }
    return _shouCarImage;
}

- (UILabel *)decripLabel{
    if (!_decripLabel) {
        _decripLabel = [[UILabel alloc] init];
        _decripLabel.text =@"购物车还是空的，快去挑选宝贝吧~";
        _decripLabel.textColor =[UIColor colorWithRed:0.45 green:0.70 blue:0.75 alpha:1.00];
        _decripLabel.textAlignment =NSTextAlignmentCenter;
    }
    return _decripLabel;
}

- (UIButton *)buyButton{
    if (!_buyButton) {
        _buyButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_buyButton setBackgroundImage:[UIImage imageNamed:@"购物车界面逛一逛按钮"] forState:UIControlStateNormal];
    }
    return _buyButton;
}

@end
