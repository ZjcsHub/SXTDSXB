//
//  ZJCHeaderLogInView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/20.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCHeaderLogInView.h"

@interface ZJCHeaderLogInView ()

@property (nonatomic,strong) UIImageView * headImage; /**头像图片 */

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UILabel * attributeLabel;

@property (nonatomic,strong) UIImageView * background;

@end


@implementation ZJCHeaderLogInView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.background];
        [self addSubview:self.headImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.attributeLabel];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakself =self;
    
    [_background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself).insets(UIEdgeInsetsZero);
    }];
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mas_top).offset(25);
        make.width.equalTo(weakself.headImage.mas_height).multipliedBy(1);
        make.bottom.equalTo(weakself.mas_bottom).offset(-24);
        make.left.equalTo(weakself.mas_left).offset(57);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mas_top).offset(38);
        make.left.equalTo(weakself.headImage.mas_right).offset(39);
        make.height.equalTo(@18);
        make.right.equalTo(weakself);
    }];
    [_attributeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.nameLabel.mas_bottom).offset(20);
        make.left.equalTo(weakself.headImage.mas_right).offset(39);
        make.height.equalTo(@18);
        make.right.equalTo(weakself);
    }];
    
}

- (UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc] init];
        _headImage.backgroundColor =[UIColor yellowColor];
    }
    return _headImage;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text =@"尚学堂";
    }
    return _nameLabel;
}
- (UILabel *)attributeLabel{
    if (!_attributeLabel) {
        _attributeLabel = [[UILabel alloc] init];
        _attributeLabel.text =@"普通会员";
    }
    return _attributeLabel;
}

- (UIImageView *)background{
    if (!_background) {
         _background =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"我的背景"]];
    }
    return _background;
}

@end
