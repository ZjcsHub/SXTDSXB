//
//  ZJCFourthViewController.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/17.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCFourthViewController.h"
#import <Masonry.h>
#import "ZJCHeaderView.h"
#import "ZJCtableView.h"
#import "ZJCLandView.h"
@interface ZJCFourthViewController ()

@property (nonatomic, strong) ZJCHeaderView * headView;

@property (nonatomic, strong) ZJCtableView * tableView;

@end

@implementation ZJCFourthViewController

- (ZJCtableView *)tableView{
    if (!_tableView) {
        _tableView =[[ZJCtableView alloc] initWithFrame:CGRectMake(0, 0, 10, 10) style:UITableViewStylePlain];
        _tableView.backgroundColor =[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
        _tableView.bounces =NO;
        _tableView.tableFooterView =[[UIView alloc] init];
        
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
    }
    return _headView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
 
    __weak typeof (self) weakself =self;
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakself.view);
        make.height.equalTo(@125);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).offset(35);
        make.left.right.bottom.equalTo(weakself.view);
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
