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
@interface ZJCThirdViewController ()

@property (nonatomic, strong)ShopCarView * carView;    /** 购物车图 */

@end

@implementation ZJCThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = 0;
    self.view.backgroundColor = MainColor;
   
}

- (void)makeConstraints{
    __weak typeof (self) weakself =self;
    [_carView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view).insets(UIEdgeInsetsZero);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
            ZJCLog(@"%@",json);
            
            if (datalist.count) {
                [self.view setBackgroundColor:[UIColor orangeColor]];
            }else{
                [self.view addSubview:self.carView];
                [self makeConstraints];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
    
    

}
- (ShopCarView *)carView{
    if (!_carView) {
        _carView =[[ShopCarView alloc] init];
    }
    return _carView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
