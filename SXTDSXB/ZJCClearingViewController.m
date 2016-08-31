//
//  ZJCClearingViewController.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/30.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCClearingViewController.h"
#import "ZJCClearinView.h"
#import "ZJCOrdertable.h"
#import "ZJCButtomView.h"
#import "ZJCPayViewController.h"
@interface ZJCClearingViewController ()

@property (nonatomic, strong)ZJCClearinView * addressView;    /** 地址 */

@property (nonatomic, strong)ZJCOrdertable * tableView;    /** 表格 */

@property (nonatomic, strong)ZJCButtomView * buttonView;    /** 按钮试图 */
@end

@implementation ZJCClearingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =MainColor;
    self.title =@"结算";
    self.edgesForExtendedLayout =0;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.buttonView];
    [self makeConstraints];
}

- (void)makeConstraints{
    __weak typeof (self) weakself =self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view).insets(UIEdgeInsetsMake(0, 0, 45, 0));
    }];
    [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.tableView.mas_bottom);
        make.left.right.bottom.equalTo(weakself.view);
    }];
}
- (ZJCOrdertable *)tableView{
    if (!_tableView) {
        _tableView =[[ZJCOrdertable alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableHeaderView =self.addressView;
        _tableView.detailModel =self.modelList;
    }
    return _tableView;
}

- (ZJCClearinView *)addressView{
    if (!_addressView) {
        _addressView = [[ZJCClearinView alloc]initWithFrame:CGRectMake(0, 80, VIEW_WIDTH, 80)];
    }
    return _addressView;
}

- (ZJCButtomView *)buttonView{
    if (!_buttonView) {
        _buttonView =[[ZJCButtomView alloc] init];
        _buttonView.price = self.modelList.GoodsPrice;
        __weak typeof (self) weakself =self;
        _buttonView.payblock = ^{
            ZJCPayViewController * pay =[[ZJCPayViewController alloc] init];
            [weakself.navigationController pushViewController:pay animated:YES];
        };
    }
    return _buttonView;
}



@end
