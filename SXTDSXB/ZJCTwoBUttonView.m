//
//  ZJCTwoBUttonView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/22.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCTwoBUttonView.h"

@interface ZJCTwoBUttonView()


@end


@implementation ZJCTwoBUttonView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.button1];
        [self addSubview:self.button2];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakself =self;
    [_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(weakself);
        make.right.equalTo(weakself.button2.mas_left);
    }];
    [_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(weakself);
        make.width.equalTo(weakself.button1.mas_width);
    }];
    
}

- (UIButton *)button1{
    if (!_button1) {
        _button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _button1.frame = CGRectMake(0, 0, VIEW_WIDTH/2, 50);
        [_button1 setTitle:@"新品团购" forState:(UIControlStateNormal)];
        [_button1 setImage:[UIImage imageNamed:@"限时特卖界面新品团购图标未选中"] forState:(UIControlStateNormal)];
        [_button1 setImage:[UIImage imageNamed:@"限时特卖界面新品团购图标"] forState:(UIControlStateSelected)];
        [_button1 setTitleColor:[UIColor colorWithRed:0.00 green:0.66 blue:0.97 alpha:1.00] forState:(UIControlStateNormal)];
        [_button1 setTitleColor:[UIColor colorWithRed:1.00 green:0.00 blue:0.00 alpha:1.00] forState:(UIControlStateSelected)];
        _button1.selected = YES;
        _button1.tag =1;
    }
    return _button1;
}

- (UIButton *)button2{
    if (!_button2) {
        _button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _button2.frame = CGRectMake(VIEW_WIDTH/2, 0, VIEW_WIDTH/2, 50);
        [_button2 setTitle:@"品牌团购" forState:(UIControlStateNormal)];
        [_button2 setImage:[UIImage imageNamed:@"限时特卖界面品牌团购图标"] forState:(UIControlStateNormal)];
        [_button2 setImage:[UIImage imageNamed:@"限时特卖界面品牌团购图标选中"] forState:(UIControlStateSelected)];
        [_button2 setTitleColor:[UIColor colorWithRed:0.00 green:0.66 blue:0.97 alpha:1.00] forState:(UIControlStateNormal)];
        [_button2 setTitleColor:[UIColor colorWithRed:1.00 green:0.00 blue:0.00 alpha:1.00] forState:(UIControlStateSelected)];
        _button2.selected = NO;
        _button2.tag =2;
    }
    return _button2;
}


@end
