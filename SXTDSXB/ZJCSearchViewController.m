//
//  ZJCSearchViewController.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/24.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCSearchViewController.h"
#import "ZJCGoodsListHeaderButton.h"
#import "ZJCCollectionView.h"
#import "ZJCSearchModel.h"
#import "ZJCDetailGoodsController.h"
@interface ZJCSearchViewController ()

@property (nonatomic, strong)ZJCGoodsListHeaderButton * goodBtnView;    /** 按钮视图 */
@property (nonatomic, strong)ZJCCollectionView * collectionView;    /** collection视图 */
@end

@implementation ZJCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =MainColor;
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.goodBtnView];
    [self.view addSubview:self.collectionView];
    [self makeConstraints];
}

- (void)makeConstraints{
    __weak typeof (self) weakself =self;
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.goodBtnView.mas_bottom);
        make.left.right.bottom.equalTo(weakself.view);
    }];
}

- (ZJCGoodsListHeaderButton *)goodBtnView{
    if (!_goodBtnView) {
        _goodBtnView = [[ZJCGoodsListHeaderButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 27)];
        __weak typeof (self) weakself =self;
        _goodBtnView.changBlock= ^(NSString * string){
            if (weakself.dataList.count) {
               [weakself getData:string];
            }else if (weakself.scrollArray.count){
                [weakself getScrollViewData:string];
            }else if (weakself.groupArray.count){
                [weakself getGroupData:string];
            }else if (weakself.typeArray.count){
                [weakself getTypeData:string];
            }else if (weakself.butArray.count){
                [weakself getBunData:string];
            }
            
        };
    }
    return _goodBtnView;
}

#pragma mark 搜索栏进入视图
- (void)getData:(NSString *)string{
    [HttpTool postWithPath:@"appSearch/searchList.do" params:@{@"search":self.title,@"OrderName":string,@"OrderType":@"ASC"} success:^(id json) {
        NSArray * dataList =[NSArray yy_modelArrayWithClass:[ZJCSearchModel class] json:json];
        _collectionView.datalist=dataList;
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"网络请求错误")
    }];
    
}

#pragma mark 首页轮播进入视图
- (void)getScrollViewData:(NSString *)string{
    [HttpTool getWithPath:@"appGgroupon/appGrounpGoodsList.do" params:@{@"GrouponId":self.scrollId,@"OrderName":string,@"OrderType":@"ASC"} success:^(id json) {
        NSArray * datalist =[NSArray yy_modelArrayWithClass:[ZJCSearchModel class] json:json];
        _collectionView.datalist =datalist;
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"网络请求错误")
    }];

}
#pragma mark 首页团购进入视图
- (void)getGroupData:(NSString *)string{
    [HttpTool getWithPath:@"appGgroupon/appGrounpGoodsList.do" params:@{@"GrouponId":self.ActivityId,@"OrderName":string,@"OrderType":@"ASC"} success:^(id json) {
        NSArray * datalist =[NSArray yy_modelArrayWithClass:[ZJCSearchModel class] json:json];
        _collectionView.datalist =datalist;
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"网络请求错误")
    }];

}
#pragma mark 分类框进入的数据
- (void)getTypeData:(NSString *)string{
    [HttpTool getWithPath:@"classifyApp/appTypeGoodsList.do" params:@{@"TypeId":self.typeId,@"OrderName":string,@"OrderType":@"ASC"} success:^(id json) {
        NSArray * datalist =[NSArray yy_modelArrayWithClass:[ZJCSearchModel class] json:json];
        _collectionView.datalist =datalist;
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"请求错误")
    }];
}

- (void)getBunData:(NSString *)string{
    [HttpTool getWithPath:@"appShop/appShopGoodsList.do" params:@{@"ShopId":self.shopId,@"OrderName":string,@"OrderType":@"ASC"} success:^(id json) {
        NSArray * dataList = [NSArray yy_modelArrayWithClass:[ZJCSearchModel class] json:json];
        _collectionView.datalist =dataList;
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"网络请求错误")
    }];

}

-(ZJCCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flow =[[UICollectionViewFlowLayout alloc] init];
        flow.itemSize =CGSizeMake((VIEW_WIDTH -15)/2, 254);
        flow.minimumLineSpacing =5;
        flow.minimumInteritemSpacing =5;
        flow.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _collectionView =[[ZJCCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        if (self.scrollArray.count) {
            _collectionView.datalist = self.scrollArray;
        }else if(self.dataList.count){
        _collectionView.datalist =self.dataList;
        }else if (self.groupArray.count){
            _collectionView.datalist =self.groupArray;
        }else if (self.typeArray.count){
            _collectionView.datalist =self.typeArray;
        }else if (self.butArray.count){
            _collectionView.datalist =self.butArray;
        }
        __weak typeof (self) weakself =self;
        _collectionView.pushBlock = ^(NSString * GoodsId,NSString * imageName,NSString * title){
            ZJCDetailGoodsController * goodsID =[[ZJCDetailGoodsController alloc] init];
            goodsID.goodsid =GoodsId;
            goodsID.CountryImg =imageName;
            goodsID.title =title;
            
            [weakself.navigationController pushViewController:goodsID animated:YES];
  
        };
        
    }
    return _collectionView;
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
