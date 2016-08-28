//
//  ZJCThirdViewController.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/17.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCThirdViewController.h"
#import "ShopCarView.h"
#import "ZJCShopCarModel.h"
#import "ZJCShopCarTableView.h"
#import "ZJCCountView.h"
@interface ZJCThirdViewController ()

@property (nonatomic, strong)ShopCarView * carView;    /** 购物车图 */

@property (nonatomic, strong)ZJCShopCarTableView * tableView;    /** 表格 */

@property (nonatomic, strong)ZJCCountView * countView;    /** 低端视图 */

@property (nonatomic, strong)NSMutableArray * model;    /** 模型数组 */
@end

@implementation ZJCThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainColor;
   
}

- (NSMutableArray *)model{
    if (!_model) {
        _model = [NSMutableArray arrayWithArray:_tableView.datalist];
    }
    return _model;
}

- (void)makeConstraints{
    __weak typeof (self) weakself =self;
    [_carView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view).insets(UIEdgeInsetsZero);
    }];
}
- (void)makeTbaleViewConstranints{
    __weak typeof (self) weakself =self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(weakself.view).insets(UIEdgeInsetsMake(0, 0, 55, 0));
    }];
    [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.tableView.mas_bottom);
        make.left.right.bottom.equalTo(weakself.view);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = 0;
     [self getShoppingCarData];
}

- (void)getShoppingCarData{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"LoginData"]) {
        [self.view addSubview:self.carView];
        [self makeConstraints];
    }else{
        NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginData"];
        [HttpTool getWithPath:@"appShopCart/appCartGoodsList.do" params:@{@"MemberId":dict[@"MemberId"]} success:^(id json) {
            NSArray * datalist =[NSArray yy_modelArrayWithClass:[ZJCShopCarModel class] json:json];
        if (datalist.count) {
            [self.view addSubview:self.tableView];
            [self.view addSubview:self.countView];
            [self getPrice];
            [self makeTbaleViewConstranints];
            [_tableView.datalist addObjectsFromArray:datalist];
            [_tableView.heightDict removeAllObjects];
            [_tableView reloadData];
        }else{
            [self.view addSubview:self.carView];
            [self makeConstraints];
        }
            
        } failure:^(NSError *error) {
            
        }];
    }
}

- (void)getPrice{
     NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginData"];
    [HttpTool getWithPath:@"appShopCart/appCartGoodsList.do" params:@{@"MemberId":dict[@"MemberId"]} success:^(id json) {
        NSArray * datalist =[NSArray yy_modelArrayWithClass:[ZJCShopCarModel class] json:json];
        _countView.priceArray =datalist;
    } failure:^(NSError *error) {
        
    }];

}

- (ShopCarView *)carView{
    if (!_carView) {
        _carView =[[ShopCarView alloc] init];
    }
    return _carView;
}

- (ZJCShopCarTableView *)tableView{
    if (!_tableView) {
        _tableView =[[ZJCShopCarTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        __weak typeof (self) weakself =self;
        _tableView.priceBlock = ^{
            [weakself getPrice];
        };
        _tableView.deleteblock =^{
            [weakself.tableView removeFromSuperview];
            [weakself.countView removeFromSuperview];
            [weakself.view addSubview:weakself.carView];
        };
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonChange:) name:@"Price" object:nil];
    }
    return _tableView;
}

- (ZJCCountView *)countView{
    if(!_countView){
        _countView =[[ZJCCountView alloc] init];
    }
    return _countView;
}

- (void)buttonChange:(NSNotification *)not{
    ZJCLog(@"%@",not.object);
    for (ZJCShopCarModel * shopModel in _tableView.datalist) {
        if([shopModel.Abbreviation isEqualToString:not.object[@"name"]]&&[not.object[@"select"] isEqual:@(0)]){
            [self.model removeObject:shopModel];
            ZJCLog(@"%lu",(unsigned long)self.model.count);
            ZJCLog(@"%lu",(unsigned long)_tableView.datalist.count);
        }else if([shopModel.Abbreviation isEqualToString:not.object[@"name"]]&&[not.object[@"select"] isEqual:@(1)]){
            [self.model addObject:shopModel];
        }
    }
    _countView.priceArray = self.model;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
