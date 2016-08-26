//
//  ZJCPhonetest.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/18.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCPhonetest.h"
#import "ZJCPhoneView.h"
#import "ZJCFourthViewController.h"
@interface ZJCPhonetest ()

@property (nonatomic, strong) ZJCPhoneView * phoneview;

@end

@implementation ZJCPhonetest

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"验证手机号";
    self.view.backgroundColor =MainColor;
    self.edgesForExtendedLayout =0;
    [self.view addSubview:self.phoneview];
    [self makeConstraint];
    [self getMessage];
}
#pragma mark - 添加视图约束
- (void)makeConstraint{
    __weak typeof (self) weakself =self;
    [_phoneview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakself.view);
        make.height.equalTo(@200);
    }];
}

#pragma mark - 懒加载
- (ZJCPhoneView *)phoneview{
    if (!_phoneview) {
        _phoneview = [[ZJCPhoneView alloc] init];
        NSString * telestring;
        if (self.usermessage) {
            telestring = [NSString stringWithFormat:@" +86%@",self.usermessage[@"username"]];
        }else if (self.thirdLogMessage){
        telestring = [NSString stringWithFormat:@" +86%@",self.thirdLogMessage[@"username"]];
        }
       
        NSString * string = [@"验证码已发送到" stringByAppendingString:telestring];
        NSMutableAttributedString * attstring =[[NSMutableAttributedString alloc] initWithString:string];
        NSDictionary * dict =@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithRed:0.00 green:0.72 blue:0.97 alpha:1.00]};
        NSRange range =[string rangeOfString:telestring];
        [attstring addAttributes:dict range:range];
        _phoneview.headerlabel.attributedText =attstring;
        _phoneview.headerlabel.font =[UIFont systemFontOfSize:14];
        [_phoneview.timebutton addTarget:self action:@selector(tryAgain) forControlEvents:UIControlEventTouchUpInside];
        }
            __weak typeof (self) weakself =self;
            _phoneview.pushBlock=^(NSString * code){
                if (weakself.usermessage) {
            //注册网络请求
                    [weakself registerController:code];
                }else if (weakself.thirdLogMessage){
                    [weakself registerthieeMessage:code];
                }
            };
    
    return _phoneview;
}

- (void)tryAgain{
    [self getMessage];
}


#pragma mark - 获取验证码信息
- (void)getMessage{
    NSString * username;
    if (self.usermessage) {
        username =[self.usermessage objectForKey:@"username"];
    }else if(self.thirdLogMessage){
        username =[self.thirdLogMessage objectForKey:@"username"];
    }
    [HttpTool postWithPath:@"appMember/createCode.do" params:@{@"MemberId":username} success:^(id json) {
    
        if ([json[@"result"] isEqualToString:@"TelephoneExistError"]) {
            ALERTSTRING(self.view, @"手机号已被注册")
        }else if([json[@"result"] isEqualToString:@"error"]){
            ALERTSTRING(self.view, @"不存在手机号")
        }else{
        [self.phoneview createTimer];
        }
    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"请求错误")
    }];
}

- (void)registerController:(NSString *)code{
    [HttpTool getWithPath:@"appMember/appRegistration.do" params:@{@"LoginName":[self.usermessage objectForKey:@"username"],@"Lpassword":[self.usermessage objectForKey:@"password"],@"Code":code,@"Telephone":[self.usermessage objectForKey:@"username"]} success:^(id json) {
        if ([json[@"result"] isEqualToString:@"TelephoneExistError"]) {
            ALERTSTRING(self.view, @"手机号已经注册")
        }
         NSDictionary * dict =@{@"LoginName":[self.usermessage objectForKey:@"username"],@"Lpassword":[self.usermessage objectForKey:@"password"]};
        [self autoLogin:dict];
        
    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"注册失败")
    }];
}

- (void)registerthieeMessage:(NSString *)code{

    
    [HttpTool getWithPath:@"appMember/appRegistration.do" params:@{@"LoginName":[self.thirdLogMessage objectForKey:@"username"],@"Lpassword":@"123123",@"Code":code,@"Telephone":[self.thirdLogMessage objectForKey:@"username"]} success:^(id json) {
        NSDictionary * dict =@{@"LoginName":[self.thirdLogMessage objectForKey:@"username"],@"Lpassword":@"123123"};
        [self autoLogin:dict];
        
    } failure:^(NSError *error) {
    ALERTSTRING(self.view, @"注册失败")
    }];
}

- (void)autoLogin:(NSDictionary *)dict{
    [HttpTool getWithPath:@"appMember/appLogin.do" params:dict success:^(id json) {
        __weak typeof (self) weakself =self;
        if ([json[@"ErrorMessage"] isEqualToString:@"密码错误"]) {
            ALERTSTRING(weakself.view, @"密码错误")
        }else if ([json[@"ErrorMessage"] isEqualToString:@"用户不存在"]){
            ALERTSTRING(weakself.view, @"用户不存在")
        }else{
            ALERTSTRING(weakself.view, @"登录成功")
            if (self.usermessage) {
                [[NSUserDefaults standardUserDefaults] setObject:json forKey:@"LoginData"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself.navigationController popToRootViewControllerAnimated:YES];
                });
            }else if (self.thirdLogMessage){
                [[NSUserDefaults standardUserDefaults] setObject:self.thirdLogMessage forKey:@"LoginData"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakself.navigationController popToRootViewControllerAnimated:YES];
                });

            }
           
        }
    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"请检查网络")

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
