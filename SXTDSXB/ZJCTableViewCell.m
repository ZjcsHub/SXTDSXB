//
//  ZJCTableViewCell.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/17.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCTableViewCell.h"

@interface ZJCTableViewCell()

@property (nonatomic,strong) UILabel * linelabel;


@end


@implementation ZJCTableViewCell

-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView =[[UIImageView alloc] init];
        
    }
    return _iconView;
}

-(UIImageView *)nextimage{
    if (!_nextimage) {
        _nextimage =[[UIImageView alloc] init];
        _nextimage.contentMode =UIViewContentModeScaleAspectFit;
    }
    return _nextimage;
}

-(UILabel *)linelabel{
    if (!_linelabel) {
        _linelabel =[[UILabel alloc] init];
        _linelabel.backgroundColor =[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    }
    return _linelabel;
}

- (UILabel *)namelabel{
    if (!_namelabel) {
        _namelabel =[[UILabel alloc] init];
        _namelabel.font =[UIFont systemFontOfSize:14];
    }
    return _namelabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.iconView];
        [self addSubview:self.namelabel];
        [self addSubview:self.nextimage];
        [self addSubview:self.linelabel];
        [self make];
        
    }
    return self;
}

- (void)make{
    __weak typeof (self) weakself =self;
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY);
        make.left.equalTo(weakself.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(130, weakself.frame.size.height));
        make.left.equalTo(weakself.iconView.mas_right).offset(15);
    }];
    [_linelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.bottom.right.equalTo(weakself);
        make.left.equalTo(weakself.iconView.mas_right).offset(15);
    }];
    
    [_nextimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY);
        make.right.equalTo(@-15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];

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
