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
#import "ZJCFourthViewController.h"

@interface ZJCLogInController ()

@property (nonatomic ,strong) ZJCLogInView * loginView;

@property (nonatomic ,strong) ZJCThreeButton * buttonView;

@end

@implementation ZJCLogInController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"登录";
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
        __weak typeof (self) weakself =self;
        
        _loginView.block =^(NSDictionary * dict){
    
        [HttpTool getWithPath:@"appMember/appLogin.do" params:dict success:^(id json) {
            ZJCLog(@"%@",json);
            
            if ([json[@"ErrorMessage"] isEqualToString:@"密码错误"]) {
                ALERTSTRING(weakself.view, @"密码错误")
            }else if ([json[@"ErrorMessage"] isEqualToString:@"用户不存在"]){
                 ALERTSTRING(weakself.view, @"用户不存在")
            }else{
                ALERTSTRING(weakself.view, @"登录成功")
                weakself.iconImage = (NSDictionary *)json;
            [[NSUserDefaults standardUserDefaults] setObject:json forKey:@"LoginData"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.navigationController popToRootViewControllerAnimated:YES];
                });
            }
        } failure:^(NSError *error) {
            ALERTSTRING(weakself.view, @"请求错误")
            }];
        };
    }
    return _loginView;
}

- (ZJCThreeButton *)buttonView{
    if (!_buttonView) {
        _buttonView = [[ZJCThreeButton alloc] init];
        __weak typeof (self) weakself =self;
        _buttonView.logblock =^(NSString * const string){
            [weakself loginController:string];
        };
    }
    return _buttonView;
}

- (void)loginController:(NSString *const)string{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:string];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            //            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            ZJCLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
            //            ZJCLog(@"--- %@",dict[@"userName"]);
            NSDictionary * dict =@{@"MemberName":snsAccount.userName,@"iconUrl":snsAccount.iconURL,@"MemberLvl":@"普卡会员"};
            [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"LoginData"];
            ALERTSTRING(self.view, @"登录成功")
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
