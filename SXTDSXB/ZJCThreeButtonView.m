//
//  ZJCThreeButtonView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/24.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCThreeButtonView.h"

@interface ZJCThreeButtonView ()

@property (nonatomic, strong)UIButton * shopingCar;    /** 购物车 */

@property (nonatomic, strong)UIButton * addButton;    /** 加入购物车 */

@property (nonatomic, strong)UIButton * buyButton;    /** 立即购买 */

@end

@implementation ZJCThreeButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.shopingCar];
        [self addSubview:self.addButton];
        [self addSubview:self.buyButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakself =self;
    [_shopingCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself).offset(13);
        make.top.equalTo(weakself.mas_top).offset(8);
        make.bottom.equalTo(weakself.mas_bottom).offset(-8);
        make.right.equalTo(weakself.addButton.mas_left).offset(-34);
        make.width.equalTo(weakself.shopingCar.mas_height).multipliedBy(1);
    }];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mas_top).offset(5);
        make.bottom.equalTo(weakself.mas_bottom).offset(-5);
        make.right.equalTo(weakself.buyButton.mas_left).offset(-15);
    }];
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-15);
        make.top.equalTo(weakself.mas_top).offset(5);
        make.bottom.equalTo(weakself.mas_bottom).offset(-5);
        make.width.equalTo(@100);
    }];
    
}


-(UIButton *)shopingCar{
    if (!_shopingCar) {
        _shopingCar =[UIButton buttonWithType:UIButtonTypeCustom];
        [_shopingCar setBackgroundImage:[UIImage imageNamed:@"详情界面购物车按钮"] forState:UIControlStateNormal];
    }
    return _shopingCar;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setBackgroundColor:[UIColor colorWithRed:0.00 green:0.85 blue:1.00 alpha:1.00]];
        [_addButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00] forState:UIControlStateNormal];
    }
    return _addButton;
}

- (UIButton *)buyButton{
    if (!_buyButton) {
        _buyButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_buyButton setBackgroundColor:[UIColor colorWithRed:0.00 green:0.71 blue:0.98 alpha:1.00]];
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyButton setTitleColor:[UIColor colorWithRed:0.98 green:1.00 blue:1.00 alpha:1.00] forState:UIControlStateNormal];
    }
    return _buyButton;
}


@end
