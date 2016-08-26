//
//  DetailTitleView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/23.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "DetailTitleView.h"
#import "NSAttributedString+ZJCPriceString.h"

@interface DetailTitleView ()
@property (strong, nonatomic)   UILabel *titleLabel;              /** 标题label */
@property (strong, nonatomic)   UILabel *priceLabel;              /** 价格label */
@property (strong, nonatomic)   UILabel *priceLineLabel;              /** 价格下面的分割线 */
@property (strong, nonatomic)   UILabel *contentLabel;              /** 描述信息 */
@property (strong, nonatomic)   UIButton *nextViewButton;              /** 跳转到商户按钮 */
@property (strong, nonatomic)   UILabel *shopName;              /** 商家名 */
@property (strong, nonatomic)   UIImageView *shopIcon;              /** 商家图标 */
@property (strong, nonatomic)   UIImageView *contryImage;              /** 国旗 */
@property (strong, nonatomic)   UILabel *countryName;              /** 国家名 */
@property (strong, nonatomic)   UIImageView *nextImage;              /** 下一步指示箭头 */
@property (strong, nonatomic)   UIView *backView;              /** 去往商家按钮背景 */
@property (strong, nonatomic)   UILabel *tostTitleLabel;              /** 图文详情 */
@property (strong, nonatomic)   UILabel *tostLineLabel;              /** 提示文字线 */


@end

@implementation DetailTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.priceLineLabel];
        [self addSubview:self.backView];
        [self addSubview:self.nextViewButton];
        [self addSubview:self.shopIcon];
        [self addSubview:self.shopName];
        [self addSubview:self.countryName];
        [self addSubview:self.contryImage];
        [self addSubview:self.nextImage];
        [self addSubview:self.tostTitleLabel];
        [self addSubview:self.tostLineLabel];
        
        [self makelayoutSubviews];
    }
    return self;
}

- (void)setDescriptionmodel:(DescriptionModel *)descriptionmodel{
    _descriptionmodel =descriptionmodel;
    _titleLabel.text = descriptionmodel.Abbreviation;
    CGFloat height = [self getLabelsHeight:descriptionmodel.Abbreviation prame:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    [_contryImage sd_setImageWithURL:[NSURL URLWithString:self.CountryImg]];
    _priceLabel.attributedText =[NSAttributedString returnNexPrice:descriptionmodel.Price OldPrice:descriptionmodel.OriginalPrice Distence:descriptionmodel.Discount];
    _contentLabel.text = descriptionmodel.GoodsIntro;
    self.buycount = descriptionmodel.BuyCount;
    CGFloat contentheight = [self getLabelsHeight:descriptionmodel.GoodsIntro prame:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0]}];
    _shopName.text =descriptionmodel.BrandCNName;
    [_shopIcon sd_setImageWithURL:[NSURL URLWithString:descriptionmodel.ShopImage]];
    _countryName.text =descriptionmodel.CountryName;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(contentheight);
    }];
    if (_heightblock) {
        _heightblock(275 + height + contentheight);
    }
}
/**
 *  获取label的高度
 */
- (CGFloat)getLabelsHeight:(NSString *)string prame:(NSDictionary *)dict{
    CGFloat height =[string boundingRectWithSize:CGSizeMake(VIEW_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    return height;
}

- (void)makelayoutSubviews{
    __weak typeof (self) weakSelf =self;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(15);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.left.equalTo(weakSelf.mas_left).offset(15);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(25);
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@20);
    }];
    
    [_priceLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceLabel.mas_bottom).offset(25);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.height.equalTo(@1);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceLineLabel.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@100);
        make.top.equalTo(weakSelf.contentLabel.mas_bottom).offset(18);
    }];
    
    [_nextViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.backView).with.insets(UIEdgeInsetsMake(10, 0, 10, 0));
    }];
    
    [_shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nextViewButton.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerY.equalTo(weakSelf.nextViewButton.mas_centerY);
    }];
    
    [_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.shopIcon.mas_top).offset(5);
        make.left.equalTo(weakSelf.shopIcon.mas_right).offset(15);
        make.height.equalTo(@12);
        make.right.equalTo(weakSelf.mas_right).offset(-120);
    }];
    
    [_contryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18, 13));
        make.left.equalTo(weakSelf.shopIcon.mas_right).offset(15);
        make.bottom.equalTo(weakSelf.shopIcon.mas_bottom).offset(-5);
    }];
    
    [_countryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contryImage.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70, 15));
        make.left.equalTo(weakSelf.contryImage.mas_right).offset(5);
    }];
    
    [_nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 15));
        make.centerY.equalTo(weakSelf.shopIcon.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
    }];
    
    [_tostTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(70, 50));
        make.top.equalTo(weakSelf.backView.mas_bottom);
    }];
    
    [_tostLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.top.equalTo(weakSelf.tostTitleLabel.mas_bottom);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
    }];

}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
}

- (UILabel *)priceLineLabel{
    if (!_priceLineLabel) {
        _priceLineLabel = [[UILabel alloc]init];
        _priceLineLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    }
    return _priceLineLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1.00];
        _contentLabel.font = [UIFont systemFontOfSize:13.0];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = MainColor;
    }
    return _backView;
}
- (UIButton *)nextViewButton{
    if (!_nextViewButton) {
        _nextViewButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _nextViewButton.backgroundColor = [UIColor whiteColor];
        [_nextViewButton addTarget:self action:@selector(pushToSearchController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextViewButton;
}

- (UILabel *)shopName{
    if (!_shopName) {
        _shopName = [[UILabel alloc]init];
        _shopName.font = [UIFont systemFontOfSize:12.0];
    }
    return _shopName;
}

- (UIImageView *)shopIcon{
    if (!_shopIcon) {
        _shopIcon = [[UIImageView alloc]init];
        _shopIcon.contentMode =UIViewContentModeScaleAspectFit;
    }
    return _shopIcon;
}

- (UILabel *)countryName{
    if (!_countryName) {
        _countryName = [[UILabel alloc]init];
        _countryName.font = [UIFont systemFontOfSize:12.0];
    }
    return _countryName;
}

- (UIImageView *)contryImage{
    if (!_contryImage) {
        _contryImage = [[UIImageView alloc]init];
    }
    return _contryImage;
}

- (UIImageView *)nextImage{
    if (!_nextImage) {
        _nextImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"下一步"]];
    }
    return _nextImage;
}

- (UILabel *)tostTitleLabel{
    if (!_tostTitleLabel) {
        _tostTitleLabel = [[UILabel alloc]init];
        _tostTitleLabel.text = @"图文详情";
        _tostTitleLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _tostTitleLabel;
}

- (UILabel *)tostLineLabel{
    if (!_tostLineLabel) {
        _tostLineLabel = [[UILabel alloc]init];
        _tostLineLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    }
    return _tostLineLabel;
}

- (void)pushToSearchController{
    if (_pushBlock) {
        _pushBlock(_descriptionmodel.ShopId,_descriptionmodel.BrandCNName);
    }
}










@end
