//
//  ZJCOrderTableViewCell.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/30.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCOrderTableViewCell.h"

@interface ZJCOrderTableViewCell ()

@property (nonatomic, strong)UIImageView * image;    /** 图片 */

@property (nonatomic, strong)UILabel * namelabel;    /** 商品名 */

@property (nonatomic, strong)UILabel * priceLabel;    /** 价格名 */
@end

@implementation ZJCOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.image];
        [self addSubview:self.namelabel];
        [self addSubview:self.priceLabel];
        [self addlayoutSubviews];
    }
    return self;
}

- (void)addlayoutSubviews{
    
//    __weak typeof (self) weakself =self;
//    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(80, 80));
//        make.left.equalTo(weakself.mas_left).offset(5);
//        make.centerY.equalTo(weakself.mas_centerY);
//    }];
//    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.image.mas_right).offset(10);
//        make.right.equalTo(weakself.mas_right).offset(-10);
//        make.top.equalTo(weakself.mas_top).offset(10);
//        make.height.equalTo(@30);
//    }];
//    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(weakself.image.mas_right).offset(10);
//        make.right.equalTo(weakself.mas_right).offset(-10);
//        make.top.equalTo(weakself.namelabel.mas_bottom).offset(20);
//        make.height.equalTo(@30);
//    }];
}


- (void)setGoodsModel:(GoodsListModel *)goodsModel{
    _goodsModel =goodsModel;
    [_image sd_setImageWithURL:[NSURL URLWithString:goodsModel.ImgView]];
    _namelabel.text = goodsModel.Abbreviation;
    _priceLabel.text = goodsModel.PriceAndCount;
}

- (UIImageView *)imageView{
    if (!_image) {
        _image =[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    }
    return _image;
}

- (UILabel *)namelabel{
    if (!_namelabel) {
        _namelabel =[[UILabel alloc] initWithFrame:CGRectMake(100, 10, VIEW_WIDTH-110, 30)];
        _namelabel.numberOfLines =0;
        _namelabel.font =[UIFont systemFontOfSize:12];
    }
    return _namelabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel =[[UILabel alloc] initWithFrame:CGRectMake(100, 60, VIEW_WIDTH-110, 30)];
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
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
