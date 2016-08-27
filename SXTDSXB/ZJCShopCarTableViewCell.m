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
        
    }
    return self;
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
