//
//  ZJCRegistView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/18.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCRegistView.h"

@interface ZJCRegistView ()<UITextFieldDelegate>
@property (strong, nonatomic)   UILabel *tostLabel;              /** 提示label */
@property (strong, nonatomic)   UITextField *userNameText;              /** 手机号text */
@property (strong, nonatomic)   UITextField *passwordText;              /** 密码text */
@property (strong, nonatomic)   UIButton *nextBtn;              /** 下一步button */
@property (strong, nonatomic)   UIButton *goLoginBtn;              /** 去登录 */

@property (strong, nonatomic)   UILabel *textBackLabel;              /** 输入框背景图 */
@property (strong, nonatomic)   UILabel *textLineLabel;              /** text中间的分割线 */
@end


@implementation ZJCRegistView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.tostLabel];
        [self addSubview:self.textBackLabel];
        [self addSubview:self.userNameText];
        [self addSubview:self.passwordText];
        [self addSubview:self.textLineLabel];
        [self addSubview:self.nextBtn];
        [self addSubview:self.goLoginBtn];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakSelf =self;
    [_tostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@35);
        make.top.right.equalTo(weakSelf);
        make.left.equalTo(weakSelf.mas_left).offset(15);
    }];
    
    [_textBackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@89);
        make.top.equalTo(weakSelf.tostLabel.mas_bottom);
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
        make.top.equalTo(weakSelf.nextBtn.mas_bottom).offset(23);
    }];

}
- (UILabel *)tostLabel{
    if (!_tostLabel) {
        _tostLabel = [[UILabel alloc]init];
        _tostLabel.text = @"请输入手机号码注册新用户";
        _tostLabel.font = [UIFont systemFontOfSize:14.0];
        _tostLabel.textColor = [UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1.00];
    }
    return _tostLabel;
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
        _userNameText.delegate = self;
        _userNameText.placeholder = @"请输入手机号码";
        [_userNameText addTarget:self action:@selector(nametextchange:) forControlEvents:UIControlEventEditingChanged];
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"username"]) {
            _userNameText.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
        }
    }
    return _userNameText;
}

- (UITextField *)passwordText{
    if (!_passwordText) {
        _passwordText = [[UITextField alloc]init];
        _passwordText.delegate = self;
        _passwordText.placeholder = @"设置账号密码";
        [_passwordText addTarget:self action:@selector(passwordtextchange:) forControlEvents:UIControlEventEditingChanged];
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
        [_nextBtn setTitle:@"下一步" forState:(UIControlStateNormal)];
        _nextBtn.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00];
        [_nextBtn setTitleColor:[UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1.00] forState:(UIControlStateNormal)];
        
        _nextBtn.userInteractionEnabled =NO;
        [_nextBtn addTarget:self action:@selector(pushToPhoneController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (UIButton *)goLoginBtn{
    if (!_goLoginBtn) {
        _goLoginBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_goLoginBtn setTitle:@"去登录" forState:(UIControlStateNormal)];
        [_goLoginBtn setTitleColor:[UIColor colorWithRed:0.00 green:0.71 blue:0.98 alpha:1.00] forState:(UIControlStateNormal)];
        _goLoginBtn.backgroundColor = MainColor;
        [_goLoginBtn addTarget:self action:@selector(pushToLogInView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goLoginBtn;
}


- (void)pushToPhoneController{
    if (_block) {
        _block(@{@"username":_userNameText.text,@"password":_passwordText.text});
    }
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] isEqualToString:_userNameText.text]) {
        [[NSUserDefaults standardUserDefaults] setObject:_userNameText.text forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)pushToLogInView{
    if (_pushBlock) {
        _pushBlock();
    }
}

#pragma mark - textfileDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _userNameText && range.location > 10) {
        return NO;
    }
    return YES;
}



- (void)nametextchange:(UITextField *)textfile{
    if (textfile.text.length>10 && _passwordText.text.length>5) {
        _nextBtn.backgroundColor =[UIColor colorWithRed:0.00 green:0.71 blue:0.97 alpha:1.00];
        [_nextBtn setTitleColor:[UIColor colorWithRed:0.94 green:1.00 blue:1.00 alpha:1.00] forState:(UIControlStateNormal)];
        _nextBtn.userInteractionEnabled =YES;

    }else{
        _nextBtn.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00];
        _nextBtn.userInteractionEnabled =NO;
         [_nextBtn setTitleColor:[UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1.00] forState:(UIControlStateNormal)];
        
    }
}

- (void)passwordtextchange:(UITextField *)textfile{
    if (textfile.text.length>5 && _userNameText.text.length>10) {
        _nextBtn.backgroundColor =[UIColor colorWithRed:0.00 green:0.71 blue:0.97 alpha:1.00];
        [_nextBtn setTitleColor:[UIColor colorWithRed:0.94 green:1.00 blue:1.00 alpha:1.00] forState:(UIControlStateNormal)];
        _nextBtn.userInteractionEnabled =YES;
        
    }else{
        _nextBtn.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00];
        _nextBtn.userInteractionEnabled =NO;
         [_nextBtn setTitleColor:[UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1.00] forState:(UIControlStateNormal)];
    }
}

@end
