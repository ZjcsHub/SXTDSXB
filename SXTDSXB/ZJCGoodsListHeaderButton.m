//
//  ZJCGoodsListHeaderButton.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/24.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCGoodsListHeaderButton.h"
@interface ZJCGoodsListHeaderButton ()

@property (nonatomic, strong)UIButton * hostBtn;    /** 热门 */

@property (nonatomic, strong)UIButton * priceBtn;    /** 价格 */

@property (nonatomic, strong)UIButton * goodBtn;    /** 好评 */

@property (nonatomic, strong)UIButton * newsBtn;    /** 新品 */

@property (nonatomic, strong) UILabel * linelabel;    /** 下划线 */

@property (nonatomic, strong) UIButton * seleBtn;    /** 选中的按钮 */
@end


@implementation ZJCGoodsListHeaderButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.hostBtn];
        [self addSubview:self.priceBtn];
        [self addSubview:self.goodBtn];
        [self addSubview:self.newsBtn];
        [self addSubview:self.linelabel];
        self.seleBtn =self.hostBtn;
        [self makeContentsLayout];
        
    }
    return self;
}

- (void)makeContentsLayout{
    __weak typeof (self) weakself =self;
    
       [_hostBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(weakself);
        make.width.mas_equalTo(VIEW_WIDTH/4);
    }];
    [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakself);
        make.left.equalTo(weakself.hostBtn.mas_right);
        make.width.mas_equalTo(VIEW_WIDTH/4);
    }];
    [_goodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakself);
        make.left.equalTo(weakself.priceBtn.mas_right);
        make.width.mas_equalTo(VIEW_WIDTH/4);
    }];
    [_newsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakself);
        make.width.mas_equalTo(VIEW_WIDTH/4);
        make.left.equalTo(weakself.goodBtn.mas_right);
    }];
    [_linelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(43, 1));
        make.centerX.equalTo(weakself.hostBtn.mas_centerX);
        make.bottom.equalTo(weakself.mas_bottom);
    }];
}



- (void)lableMove:(UIButton *)selectionBtn{
    selectionBtn.selected =YES;
    self.seleBtn.selected = NO;
    self.seleBtn =selectionBtn;
    [self setNeedsUpdateConstraints];

    [self updateConstraintsIfNeeded];

    __weak typeof (self) weakself =self;
    [_linelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(43, 1));
        make.centerX.equalTo(selectionBtn.mas_centerX);
        make.bottom.equalTo(weakself.mas_bottom);
    }];

    [UIView animateWithDuration:0.3 animations:^{
        
        [self layoutIfNeeded];
    
    }];
    NSString * string;
    switch (selectionBtn.tag) {
        case 0:
            string =@"host";
            break;
        case 1:
            string =@"price";
            case 2:
            string =@"score";
            case 3:
            string =@"time";
        default:
            break;
    }
    
    
    if (_changBlock) {
        _changBlock(string);
    }
    
    
}



- (UIButton *)hostBtn{
    if (!_hostBtn) {
        _hostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hostBtn setTitle:@"热门" forState:UIControlStateNormal];
        _hostBtn.titleLabel.font =[UIFont systemFontOfSize:13];
        [_hostBtn setTitleColor:[UIColor colorWithRed:0.00 green:0.70 blue:0.97 alpha:1.00] forState:UIControlStateSelected];
        [_hostBtn setTitleColor:[UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00] forState:UIControlStateNormal];
        [_hostBtn addTarget:self action:@selector(lableMove:) forControlEvents:UIControlEventTouchUpInside];
        _hostBtn.selected =YES;
        _hostBtn.tag =0;
    }
    return _hostBtn;
}

- (UIButton *)priceBtn{
    if (!_priceBtn) {
        _priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_priceBtn setTitle:@"价格" forState:UIControlStateNormal];
        _priceBtn.titleLabel.font =[UIFont systemFontOfSize:13];
        [_priceBtn setTitleColor:[UIColor colorWithRed:0.00 green:0.70 blue:0.97 alpha:1.00] forState:UIControlStateSelected];
        [_priceBtn setTitleColor:[UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00] forState:UIControlStateNormal];
        [_priceBtn addTarget:self action:@selector(lableMove:) forControlEvents:UIControlEventTouchUpInside];
        _priceBtn.selected =NO;
        _priceBtn.tag =1;
    }
    return _priceBtn;
}

- (UIButton *)goodBtn{
    if (!_goodBtn) {
        _goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goodBtn setTitle:@"好评" forState:UIControlStateNormal];
        _goodBtn.titleLabel.font =[UIFont systemFontOfSize:13];
        [_goodBtn setTitleColor:[UIColor colorWithRed:0.00 green:0.70 blue:0.97 alpha:1.00] forState:UIControlStateSelected];
        [_goodBtn setTitleColor:[UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00] forState:UIControlStateNormal];
         [_goodBtn addTarget:self action:@selector(lableMove:) forControlEvents:UIControlEventTouchUpInside];
        _goodBtn.selected =NO;
        _goodBtn.tag=2;
    }
    return _goodBtn;
}

- (UIButton *)newsBtn{
    if (!_newsBtn) {
        _newsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_newsBtn setTitle:@"新品" forState:UIControlStateNormal];
        _newsBtn.titleLabel.font =[UIFont systemFontOfSize:13];
        [_newsBtn setTitleColor:[UIColor colorWithRed:0.00 green:0.70 blue:0.97 alpha:1.00] forState:UIControlStateSelected];
        [_newsBtn setTitleColor:[UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00] forState:UIControlStateNormal];
         [_newsBtn addTarget:self action:@selector(lableMove:) forControlEvents:UIControlEventTouchUpInside];
        _newsBtn.selected =NO;
        _newsBtn.tag =3;
    }
    return _newsBtn;
}

- (UILabel *)linelabel{
    if (!_linelabel) {
        _linelabel = [[UILabel alloc] init];
        _linelabel.backgroundColor =[UIColor colorWithRed:0.00 green:0.70 blue:0.97 alpha:1.00];
    }
    return _linelabel;
}

@end
