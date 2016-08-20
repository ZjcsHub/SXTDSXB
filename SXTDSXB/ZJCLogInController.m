//
//  ZJCLogInController.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/20.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCLogInController.h"
#import "ZJCLogInView.h"
#import "ZJCThreeButton.h"


@interface ZJCLogInController ()

@property (nonatomic ,strong) ZJCLogInView * loginView;

@property (nonatomic ,strong) ZJCThreeButton * buttonView;

@end

@implementation ZJCLogInController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:MainColor];
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.buttonView];
    [self makeConstraint];
}

- (void)makeConstraint{
    __weak typeof (self) weakself =self;
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakself.view);
        make.height.equalTo(@210);
    }];
    [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.loginView.mas_bottom);
        make.right.left.equalTo(weakself.view);
        make.height.equalTo(@100);
    }];
}

- (ZJCLogInView *)loginView{
    if (!_loginView) {
        _loginView = [[ZJCLogInView alloc] init];
    }
    return _loginView;
}

- (ZJCThreeButton *)buttonView{
    if (!_buttonView) {
        _buttonView = [[ZJCThreeButton alloc] init];
    }
    return _buttonView;
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
