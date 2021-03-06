//
//  ZJCFourthViewController.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/17.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCFourthViewController.h"
#import "ZJCLogInController.h"
#import "ZJCHeaderView.h"
#import "ZJCtableView.h"
#import "ZJCLandView.h"
@interface ZJCFourthViewController ()

@property (nonatomic, strong) ZJCHeaderView * headView;

@property (nonatomic, strong) ZJCtableView * tableView;



@end

@implementation ZJCFourthViewController

-(ZJCHeaderLogInView *)logHeaderview{
    if (!_logHeaderview) {
        _logHeaderview = [[ZJCHeaderLogInView alloc] init];
    }
    return _logHeaderview;
}

- (ZJCtableView *)tableView{
    if (!_tableView) {
        _tableView =[[ZJCtableView alloc] initWithFrame:CGRectMake(0, 0, 10, 10) style:UITableViewStylePlain];
        _tableView.backgroundColor =[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
        _tableView.bounces =NO;
        __weak typeof (self) weakself =self;
        _tableView.block = ^{
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginData"];
            [weakself viewLoadData];
        };
    }
    return _tableView;
}

-(ZJCHeaderView *)headView{
    if (!_headView) {
        _headView =[[ZJCHeaderView alloc] init];
        __weak typeof (self) weakself =self;
        _headView.pushblock =^{
            [weakself.navigationController pushViewController:[[ZJCLandView alloc] init] animated:YES];

        };
        
        _headView.loginViewblock= ^{
            ZJCLogInController * loginview =[[ZJCLogInController alloc] init];
        [weakself.navigationController pushViewController:loginview animated:YES];
        };
    }
    return _headView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self viewLoadData];
}

- (void)viewLoadData{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"LoginData"]) {
        
        _logHeaderview.hidden = NO;
        _headView.hidden =YES;
        
        [self reflashData];
        [_tableView reloadData];
        
    }else{
        _logHeaderview.hidden =YES;
        _headView.hidden =NO;
        [_tableView reloadData];
    }

}

- (void)reflashData{
    NSDictionary * dict =[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginData"];
    _logHeaderview.nameLabel.text = dict[@"MemberName"];
    _logHeaderview.attributeLabel.text =dict[@"MemberLvl"];
    [_logHeaderview.headImage downloadImage:dict[@"iconUrl"] placeholder:@"图标"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.logHeaderview];
    __weak typeof (self) weakself =self;
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakself.view);
        make.height.equalTo(@125);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).offset(35);
        make.left.right.bottom.equalTo(weakself.view);
    }];
    
    [self.logHeaderview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakself.view);
        make.height.equalTo(@125);

    }];
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
