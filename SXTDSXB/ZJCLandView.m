//
//  ZJCLandView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/18.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCLandView.h"
#import "ZJCRegistView.h"
#import "ZJCThreeButton.h"
#import "ZJCPhonetest.h"
#import "NSArray+Log.h"
#import "PhoneNumberRegister.h"
@interface ZJCLandView ()<UITextFieldDelegate>

@property (nonatomic, strong) ZJCRegistView * regisView;

@property (nonatomic, strong) ZJCThreeButton * buttonView;
@end

@implementation ZJCLandView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = MainColor;
    self.edgesForExtendedLayout = 0;
   
    [self.view addSubview:self.regisView];
    [self.view addSubview:self.buttonView];
    
    __weak typeof (self) weakself =self;
    [self.regisView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(weakself.view);
        make.height.equalTo(@225);
    }];
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.regisView.mas_bottom);
        make.left.right.equalTo(weakself.view);
        make.height.equalTo(@100);
    }];
    
}

-(ZJCRegistView *)regisView{
    if (!_regisView) {
        _regisView =[[ZJCRegistView alloc] init];
        __weak typeof (self) weakself =self;
        _regisView.block =^(NSDictionary * dict){
            ZJCPhonetest * test =[[ZJCPhonetest alloc] init];
            test.usermessage =dict;
            [weakself.navigationController pushViewController:test animated:YES];
        };
    }
    return _regisView;
}
-(ZJCThreeButton *)buttonView{
    if (!_buttonView) {
        _buttonView =[[ZJCThreeButton alloc] init];
        __weak typeof (self) weakself =self;
        _buttonView.logblock =^(NSString *const string){
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
//            ZJCLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
//            ZJCLog(@"--- %@",dict[@"userName"]);
            NSDictionary * dict =@{@"MemberName":snsAccount.userName,@"iconUrl":snsAccount.iconURL,@"MemberLvl":@"普卡会员"};
            PhoneNumberRegister * phone =[[PhoneNumberRegister alloc] init];
            phone.dict =[NSMutableDictionary dictionaryWithDictionary:dict];
            [self.navigationController pushViewController:phone animated:YES];
        }
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end


