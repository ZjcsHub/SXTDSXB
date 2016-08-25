//
//  ZJCSearchViewController.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/24.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCSearchViewController.h"
#import "ZJCGoodsListHeaderButton.h"
@interface ZJCSearchViewController ()

@property (nonatomic, strong)UISearchBar * searchbar;    /** 搜索栏 */
@property (nonatomic, strong)ZJCGoodsListHeaderButton * goodBtnView;    /** 按钮视图 */

@end

@implementation ZJCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =MainColor;
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    [self.view addSubview:self.goodBtnView];
    
}

- (ZJCGoodsListHeaderButton *)goodBtnView{
    if (!_goodBtnView) {
        _goodBtnView = [[ZJCGoodsListHeaderButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 27)];
    }
    return _goodBtnView;
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
