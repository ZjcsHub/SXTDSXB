//
//  ZJCShopCarTableViewCell.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/27.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCShopCarTableViewCell.h"

@interface ZJCShopCarTableViewCell ()

@property (nonatomic, strong)UIButton * markBut;    /** 选择按钮 */

@property (nonatomic, strong)UIImageView * iconImage;    /** 商品图标 */

@property (nonatomic, strong)UILabel * namelabel;    /** 商品名 */

@property (nonatomic, strong)UILabel * priceLabel;    /** 价格名 */

@property (nonatomic, strong)UIImageView * OperationImage;    /** 背景加减图片 */

@property (nonatomic, strong)UIButton * leftbutton;    /** 左边按钮 */

@property (nonatomic, strong)UIButton * rightButton;    /** 右边按钮 */

@property (nonatomic, strong)UILabel * numlabel;    /** 数字label */
@end


@implementation ZJCShopCarTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.iconImage];
        [self addSubview:self.namelabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.OperationImage];
        [self addSubview:self.markBut];
        [self addSubview:self.leftbutton];
        [self addSubview:self.rightButton];
        [self addSubview:self.numlabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakself =self;
    [_markBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(21, 21));
        make.left.equalTo(weakself.mas_left).offset(13);
        make.centerY.equalTo(weakself.mas_centerY);
    }];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(53, 53));
        make.left.equalTo(weakself.markBut.mas_right).offset(10);
        make.centerY.equalTo(weakself.mas_centerY);
    }];
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mas_top).offset(14);
        make.left.equalTo(weakself.iconImage.mas_right).offset(18);
        make.right.equalTo(weakself.mas_right);
        make.height.equalTo(@26);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.namelabel.mas_bottom);
        make.left.equalTo(weakself.iconImage.mas_right).offset(13);
        make.size.mas_equalTo(CGSizeMake(100, 26));
    }];
    [_OperationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(85, 25));
        make.right.equalTo(weakself.mas_right).offset(-18);
        make.bottom.equalTo(weakself.mas_bottom).offset(-15);
    }];
    [_leftbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.top.left.equalTo(weakself.OperationImage);
    }];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.bottom.equalTo(weakself.OperationImage);
    }];
    [_numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakself.OperationImage);
        make.left.equalTo(weakself.leftbutton);
        make.right.equalTo(weakself.rightButton);
    }];
}

- (void)setCarModel:(ZJCShopCarModel *)carModel{
    _carModel =carModel;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:carModel.ImgView]];
    _namelabel.text =carModel.Abbreviation;
    _priceLabel.text = carModel.Price;
    _numlabel.text =carModel.GoodsCount;
}

- (UIButton *)markBut{
    if (!_markBut) {
        _markBut =[UIButton buttonWithType:UIButtonTypeCustom];
        [_markBut setImage:[UIImage imageNamed:@"购物车界面商品选中对号按钮"] forState:UIControlStateSelected];
        [_markBut setImage:[UIImage imageNamed:@"购物车界面商品未选中"] forState:UIControlStateNormal];
        _markBut.selected =YES;
    }
    return _markBut;
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage =[[UIImageView alloc] init];
    }
    return _iconImage;
}
- (UILabel *)namelabel{
    if (!_namelabel) {
        _namelabel =[[UILabel alloc] init];
    }
    return _namelabel;
}
- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel =[[UILabel alloc] init];
    }
    return _priceLabel;
}
- (UIImageView *)OperationImage{
    if (!_OperationImage) {
        _OperationImage =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"购物车界面商品加减按钮"]];
    }
    return _OperationImage;
}
- (UIButton *)leftbutton{
    if (!_leftbutton) {
        _leftbutton =[UIButton buttonWithType:UIButtonTypeSystem];
        _leftbutton.backgroundColor =[UIColor clearColor];
    }
    return _leftbutton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton= [UIButton buttonWithType:UIButtonTypeSystem];
        _rightButton.backgroundColor =[UIColor clearColor];
    }
    return _rightButton;
}

- (UILabel *)numlabel{
    if (!_numlabel) {
        _numlabel =[[UILabel alloc] init];
        _numlabel.textAlignment= NSTextAlignmentCenter;
    }
    return _numlabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
