//
//  ZJCButtomView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/30.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCButtomView.h"

@interface ZJCButtomView ()

@property (nonatomic, strong)UILabel * decressLabel;    /** 描述 */

@property (nonatomic, strong)UIButton * payButton;    /** <#描述#> */
@end

@implementation ZJCButtomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.decressLabel];
        [self addSubview:self.payButton];
    }
    return self;
}

- (void)setPrice:(NSString *)price{
    NSString * priceString =[@"￥" stringByAppendingString:price];
    NSMutableAttributedString * addString = [[NSMutableAttributedString alloc] initWithString:@"合计：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    NSAttributedString * pString = [[NSAttributedString alloc] initWithString:priceString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor colorWithRed:1.00 green:0.18 blue:0.04 alpha:1.00]}];
    [addString insertAttributedString:pString atIndex:addString.length];
    _decressLabel.attributedText = addString;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakself =self;
    [_decressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself).insets(UIEdgeInsetsMake(0, 0, 0, 120));
    }];
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.mas_right).offset(-10);
        make.top.equalTo(weakself.mas_top).offset(5);
        make.bottom.equalTo(weakself.mas_bottom).offset(-5);
        make.left.equalTo(weakself.decressLabel.mas_right).offset(20);

    }];
}

- (UILabel *)decressLabel{
    if (!_decressLabel) {
        _decressLabel =[[UILabel alloc] init];
        _decressLabel.textAlignment =NSTextAlignmentRight;
    }
    return _decressLabel;
}

- (UIButton *)payButton{
    if (!_payButton) {
        _payButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_payButton setTitle:@"立即支付" forState:UIControlStateNormal];
        [_payButton setBackgroundColor:[UIColor colorWithRed:0.00 green:0.71 blue:0.96 alpha:1.00]];
    }
    return _payButton;
}

@end
