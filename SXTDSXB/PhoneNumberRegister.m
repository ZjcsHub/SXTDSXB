//
//  PhoneNumberRegister.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/20.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "PhoneNumberRegister.h"
#import "ZJCPhonetest.h"
@interface PhoneNumberRegister ()<UITextFieldDelegate>
@property (strong, nonatomic)   UITextField *userNameText;

@property (strong, nonatomic) UIButton * button;

@property (strong, nonatomic) UILabel * backLabel;
@end

@implementation PhoneNumberRegister

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.view.backgroundColor =MainColor;
    self.edgesForExtendedLayout =0;
    [self.view addSubview:self.backLabel];
    [self.view addSubview:self.userNameText];
    [self.view addSubview:self.button];
    __weak typeof (self) weakself =self;
    
    [_backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view.mas_top).offset(20);
        make.left.right.equalTo(weakself.view);
        make.height.equalTo(@46);
    }];
    
    [_userNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakself.backLabel).offset(15);
        make.height.equalTo(@44);
        make.top.equalTo(weakself.backLabel.mas_top).offset(1);
        make.bottom.equalTo(weakself.backLabel.mas_bottom).offset(-1);
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.userNameText.mas_bottom).offset(40);
        make.left.equalTo(weakself.view).offset(16);
        make.right.equalTo(weakself.view).offset(-16);
        make.height.equalTo(@35);
    }];
}

- (UILabel *)backLabel{
    if (!_backLabel) {
        _backLabel =[[UILabel alloc] init];
        _backLabel.backgroundColor =[UIColor whiteColor];
    }
    return _backLabel;
}

- (UITextField *)userNameText{
    if (!_userNameText) {
        _userNameText = [[UITextField alloc] init];
        _userNameText.placeholder =@"输入手机号验证";
        _userNameText.delegate =self;
        [_userNameText addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _userNameText;
}
- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"验证" forState:UIControlStateNormal];
        [_button setBackgroundColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00]];
        [_button setTitleColor:[UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1.00] forState:UIControlStateSelected];
        [_button addTarget:self action:@selector(pushNumber) forControlEvents:UIControlEventTouchUpInside];
        _button.userInteractionEnabled =NO;
    }
    return _button;
}
- (void)pushNumber{
    [self.dict setObject:_userNameText.text forKey:@"username"];
    ZJCPhonetest * test =[[ZJCPhonetest alloc] init];
    test.thirdLogMessage =self.dict;
    [self.navigationController pushViewController:test animated:YES];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location > 10) {
        return NO;
    }
    return YES;
}

- (void)valueChange:(UITextField *)textfile{
    if (textfile.text.length==11) {
        [_button setBackgroundColor:[UIColor colorWithRed:0.00 green:0.71 blue:0.98 alpha:1.00]];
        _button.userInteractionEnabled =YES;
    }else{
        [_button setBackgroundColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00]];
        _button.userInteractionEnabled =NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
