//
//  ZJCHeaderView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/17.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCHeaderView.h"
#import "ZJCFourthViewController.h"
@interface ZJCHeaderView ()
@property (nonatomic ,strong) UIImageView * imageView;

@property (nonatomic, strong) UIButton * longin;

@property (nonatomic, strong) UIButton * zhuce;

@end

@implementation ZJCHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.longin];
        [self addSubview:self.zhuce];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakself =self;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself).insets(UIEdgeInsetsZero);
    }];
    [self.longin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.left.equalTo(weakself.mas_left).offset(100);
    }];
    [self.zhuce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.left.equalTo(weakself.mas_right).offset(-150);
    }];
    

}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"我的背景"]];
    }
    return _imageView;
}

- (UIButton *)longin{
    if (!_longin) {
        _longin =[UIButton buttonWithType:UIButtonTypeSystem];
        [_longin setTitle:@"登录" forState:UIControlStateNormal];
    }
    return _longin;
}

-(UIButton *)zhuce{
    if (!_zhuce) {
        _zhuce =[UIButton buttonWithType:UIButtonTypeSystem];
        [_zhuce setTitle:@"注册" forState:UIControlStateNormal];
        [_zhuce addTarget:self action:@selector(pushnextController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zhuce;
}

- (void)pushnextController{
    if (_pushblock) {
        _pushblock();
    }
   
}




@end
