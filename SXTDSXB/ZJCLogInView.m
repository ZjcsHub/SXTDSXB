//
//  ZJCLogInView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/20.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCLogInView.h"

@interface ZJCLogInView ()

@property (strong, nonatomic)   UITextField *userNameText;              /** 手机号text */
@property (strong, nonatomic)   UITextField *passwordText;              /** 密码text */
@property (strong, nonatomic)   UILabel *textBackLabel;              /** 输入框背景图 */
@property (strong, nonatomic)   UILabel *textLineLabel;              /** text中间的分割线 */
@property (strong, nonatomic)   UIButton *nextBtn;              /** 登录button */
@property (strong, nonatomic)   UIButton *goLoginBtn;              /** 去注册 */

@end


@implementation ZJCLogInView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.textBackLabel];
        [self addSubview:self.userNameText];
        [self addSubview:self.textLineLabel];
        [self addSubview:self.passwordText];
        [self addSubview:self.nextBtn];
        [self addSubview:self.goLoginBtn];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakSelf =self;
    [_textBackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@89);
        make.top.equalTo(weakSelf.mas_top).offset(20);
        make.left.equalTo(weakSelf.mas_left).offset(-1);
        make.right.equalTo(weakSelf.mas_right).offset(1);
    }];
    
    [_userNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf).offset(15);
        make.height.equalTo(@44);
        make.top.equalTo(weakSelf.textBackLabel.mas_top);
    }];
    
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf).offset(15);
        make.height.equalTo(@44);
        make.top.equalTo(weakSelf.userNameText.mas_bottom).offset(1);
    }];
    
    [_textLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(weakSelf.textBackLabel.mas_left).offset(15);
        make.right.equalTo(weakSelf.textBackLabel.mas_right).offset(-15);
        make.centerY.equalTo(weakSelf.textBackLabel.mas_centerY);
    }];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(16);
        make.right.equalTo(weakSelf.mas_right).offset(-16);
        make.height.equalTo(@35);
        make.top.equalTo(weakSelf.passwordText.mas_bottom).offset(15);
    }];
    
    [_goLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 16));
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.top.equalTo(weakSelf.nextBtn.mas_bottom).offset(18);
    }];

}

- (UILabel *)textBackLabel{
    if (!_textBackLabel) {
        _textBackLabel = [[UILabel alloc]init];
        _textBackLabel.backgroundColor = [UIColor whiteColor];
        _textBackLabel.layer.borderWidth = 1;
        _textBackLabel.layer.borderColor = [UIColor colorWithRed:0.80 green:0.78 blue:0.80 alpha:1.00].CGColor;
    }
    return _textBackLabel;
}

- (UITextField *)userNameText{
    if (!_userNameText) {
        _userNameText = [[UITextField alloc]init];
        _userNameText.placeholder = @"请输入手机号码";
        if ([[ZJCUserDefaults shareDefault] valueForKey:@"username"]) {
            _userNameText.text = [[ZJCUserDefaults shareDefault] valueForKey:@"username"];
        }
    }
    return _userNameText;
}

- (UITextField *)passwordText{
    if (!_passwordText) {
        _passwordText = [[UITextField alloc]init];
        
        _passwordText.placeholder = @"请输入密码";
       
    }
    return _passwordText;
}

- (UILabel *)textLineLabel{
    if (!_textLineLabel) {
        _textLineLabel = [[UILabel alloc]init];
        _textLineLabel.backgroundColor =[UIColor colorWithRed:0.80 green:0.78 blue:0.80 alpha:1.00];
        
    }
    return _textLineLabel;
}
- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"登录界面登录按钮"] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(popToController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (UIButton *)goLoginBtn{
    if (!_goLoginBtn) {
        _goLoginBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_goLoginBtn setTitle:@"免费注册" forState:(UIControlStateNormal)];
        [_goLoginBtn setTitleColor:[UIColor colorWithRed:0.00 green:0.71 blue:0.98 alpha:1.00] forState:(UIControlStateNormal)];
        _goLoginBtn.backgroundColor = MainColor;
    }
    return _goLoginBtn;
}

- (void)popToController{
    if (_block) {
        _block();
    }
}


@end
