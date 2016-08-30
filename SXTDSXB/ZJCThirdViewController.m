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
#import "DetailModel.h"
#import "ZJCClearingViewController.h"
@interface ZJCThirdViewController ()

@property (nonatomic, strong)ShopCarView * carView;    /** 购物车图 */

@property (nonatomic, strong)ZJCShopCarTableView * tableView;    /** 表格 */

@property (nonatomic, strong)ZJCCountView * countView;    /** 低端视图 */

@property (nonatomic, strong)NSMutableArray * array;    /** <#描述#> */

@property (nonatomic, strong)NSArray * datalist;    /** 数组 */
@end

@implementation ZJCThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MainColor;
    self.edgesForExtendedLayout = 0;
   
}

- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray arrayWithArray:_tableView.datalist];
    }
    return _array;
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
    [self getShoppingCarData];
    self.array =nil;
}

- (void)getShoppingCarData{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"LoginData"]) {
        [self.view addSubview:self.carView];
        [self makeConstraints];
    }else{
        NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginData"];
        [HttpTool getWithPath:@"appShopCart/appCartGoodsList.do" params:@{@"MemberId":dict[@"MemberId"]} success:^(id json) {
            NSArray * datalist =[NSArray yy_modelArrayWithClass:[ZJCShopCarModel class] json:json];
            for (ZJCShopCarModel * model in datalist) {
                [model setSelect:YES];
            }
        if (datalist.count) {
            [self.view addSubview:self.tableView];
            [self.view addSubview:self.countView];
            [_tableView.datalist removeAllObjects];
            [self makeTbaleViewConstranints];
            [_tableView.datalist addObjectsFromArray:datalist];
            [_tableView.heightDict removeAllObjects];
            [_tableView reloadData];
            [self getPrice];
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
        
    }failure:^(NSError *error) {

        
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
            [weakself makeConstraints];
        };
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonChange:) name:@"Price" object:nil];
    }
    return _tableView;
}

- (ZJCCountView *)countView{
    if(!_countView){
        _countView =[[ZJCCountView alloc] init];
        __weak typeof (self) weakself =self;
        _countView.payblock =^{
            NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoginData"];
            [HttpTool getWithPath:@"appShopCart/appCartGoodsList.do" params:@{@"MemberId":dict[@"MemberId"]} success:^(id json) {
                
                NSArray * datalist =[NSArray yy_modelArrayWithClass:[ZJCShopCarModel class] json:json];
                weakself.datalist = datalist;
                [weakself goToPay];
            } failure:^(NSError *error) {
            }];
        };
    }
    return _countView;
}

- (void)goToPay{
    
    NSMutableArray * array = [NSMutableArray array];
    for (ZJCShopCarModel * model in self.datalist) {
        NSString * string =[NSString stringWithFormat:@"%@,%@,%@",model.GoodsCount,model.GoodsId,model.Weight];
        [array addObject:string];
    }
    
    NSString * lastSting = [array componentsJoinedByString:@"#"];
    __weak typeof (self) weakself =self;
    [HttpTool getWithPath:@"appOrder/gotoInsert.do" params:@{@"Goods":lastSting}
                  success:^(id json) {
    DetailModel * model = [DetailModel yy_modelWithDictionary:json];
                      ZJCLog(@"%@",json);
    ZJCClearingViewController * clearingVc =[[ZJCClearingViewController alloc] init];
    clearingVc.modelList = model;
    [weakself.navigationController pushViewController:clearingVc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}

- (void)makeInsertDict {
   
}
- (void)buttonChange:(NSNotification *)not{
    
    ZJCLog(@"%@",not.userInfo);
    for (ZJCShopCarModel * model in _tableView.datalist) {
        if ([model.Abbreviation isEqualToString:not.object]&&[@(model.select) isEqual:@(0)]) {
            [self.array removeObject:model];
        }else if([model.Abbreviation isEqualToString:not.object]&&[@(model.select) isEqual:@(1)]){
            [self.array addObject:model];
        }
    }
    _countView.priceArray = _array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
