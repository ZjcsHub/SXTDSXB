//
//  ZJCFountionViewCell.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/25.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCFountionViewCell.h"

@interface ZJCFountionViewCell ()

@end


@implementation ZJCFountionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.goodsType];
        [self addSubview:self.describeLabel];
        self.backgroundColor =[UIColor whiteColor];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakself =self;
    [_goodsType mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(weakself);
        make.top.left.equalTo(weakself).offset(10);
        make.right.equalTo(weakself).offset(-10);
        make.height.equalTo(@44);
    }];
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(weakself);
        make.height.equalTo(weakself.goodsType.mas_height).multipliedBy(0.5);
    }];
}
- (UIImageView *)goodsType{
    if (!_goodsType) {
        _goodsType =[[UIImageView alloc] init];
        _goodsType.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goodsType;
}

- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel =[[UILabel alloc] init];
        _describeLabel.textAlignment =NSTextAlignmentCenter;
        _describeLabel.font =[UIFont systemFontOfSize:12];
    }
    return _describeLabel;
}

@end
