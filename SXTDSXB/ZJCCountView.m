//
//  ZJCCountView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/28.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCCountView.h"
#import "ZJCShopCarModel.h"
@interface ZJCCountView ()

@property (nonatomic, strong)UILabel * priceLabel;    /** 价格 */

@property (nonatomic, strong)UILabel * decripLabel;    /** 描述 */

@property (nonatomic, strong)UIButton * goTosettle;    /** 去结算 */
@end

@implementation ZJCCountView

- (void)setPriceArray:(NSArray *)priceArray{
    CGFloat price =0;
    for (ZJCShopCarModel * model in priceArray) {
        CGFloat buyPrice =[model.Price floatValue] * [model.GoodsCount floatValue];
        price += buyPrice;
    }
    NSString * priceString = [NSString stringWithFormat:@"%.2f",price];
    priceString = [@"￥" stringByAppendingString:priceString];
    NSMutableAttributedString * addString = [[NSMutableAttributedString alloc] initWithString:@"合计：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    NSAttributedString * pString = [[NSAttributedString alloc] initWithString:priceString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor colorWithRed:1.00 green:0.18 blue:0.04 alpha:1.00]}];
    [addString insertAttributedString:pString atIndex:addString.length];
    _priceLabel.attributedText = addString;

}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.priceLabel];
        [self addSubview:self.decripLabel];
        [self addSubview:self.goTosettle];
        self.backgroundColor =[UIColor whiteColor];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakself =self;
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakself);
        make.size.mas_equalTo(CGSizeMake(130, 27));
    }];
    [_decripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.priceLabel.mas_bottom);
        make.left.bottom.equalTo(weakself);
        make.width.equalTo(weakself.priceLabel.mas_width);
    }];
    [_goTosettle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mas_top).offset(10);
        make.bottom.equalTo(weakself.mas_bottom).offset(-10);
        make.right.equalTo(weakself.mas_right).offset(-15);
        make.width.equalTo(@110);
    }];
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textAlignment =NSTextAlignmentRight;
    }
    return _priceLabel;
}

- (UILabel *)decripLabel{
    if (!_decripLabel) {
        _decripLabel =[[UILabel alloc] init];
        _decripLabel.textAlignment =NSTextAlignmentRight;
        _decripLabel.text =@"(全场包邮)";
        _decripLabel.textColor =[UIColor colorWithRed:0.41 green:0.41 blue:0.41 alpha:1.00];
        _decripLabel.font =[UIFont systemFontOfSize:15];
    }
    return _decripLabel;
}

- (UIButton *)goTosettle{
    if (!_goTosettle) {
        _goTosettle =[UIButton buttonWithType:UIButtonTypeCustom];
        [_goTosettle setBackgroundImage:[UIImage imageNamed:@"购物车界面去结算按钮"] forState:UIControlStateNormal];
    }
    return _goTosettle;
}
@end
