//
//  ZJCSecondViewController.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/17.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCSecondViewController.h"
#import "ZJCFountionCollectionView.h"
#import "Model.h"
#import "ZJCSearchViewController.h"
#import "ZJCSearchModel.h"
@interface ZJCSecondViewController ()

@property (nonatomic, strong)ZJCFountionCollectionView * collection;    /**  */

@end

@implementation ZJCSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.collection];
    __weak typeof (self) weakself =self;
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view).insets(UIEdgeInsetsZero);
    }];
    [self getData];
}


- (void)getData{
    [HttpTool getWithPath:@"classifyApp/getGoodsClassify.do" params:nil success:^(id json) {
        NSArray * dataList =[NSArray yy_modelArrayWithClass:[Model class] json:json];
        _collection.datalist =dataList;
        [_collection reloadData];
    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"请检查网络")
    }];
}

- (ZJCFountionCollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
        NSInteger width = 0;
        if (VIEW_WIDTH == 414) {
            width =(VIEW_WIDTH -6)/5;
        }else{
            width =(VIEW_WIDTH - 5) /4;
        }
        flow.itemSize =CGSizeMake(width, width);
    
        flow.minimumLineSpacing =1;
        flow.minimumInteritemSpacing =1;
//        flow.sectionInset =UIEdgeInsetsMake(40, 1, 0, 1);
        flow.headerReferenceSize =CGSizeMake(VIEW_WIDTH, 40);
        _collection =[[ZJCFountionCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        __weak typeof (self) weakself =self;
        _collection.block =^(NSString * typeId,NSString * titleName){
            [weakself getTypeIdData:typeId titleName:titleName];
        };
    }
    return _collection;
}

- (void)getTypeIdData:(NSString *)typeid titleName:(NSString *)titlename{
    [HttpTool getWithPath:@"classifyApp/appTypeGoodsList.do" params:@{@"TypeId":typeid,@"OrderName":@"host",@"OrderType":@"ASC"} success:^(id json) {
        NSArray * datalist =[NSArray yy_modelArrayWithClass:[ZJCSearchModel class] json:json];
        
        ZJCSearchViewController * searchVc =[[ZJCSearchViewController alloc] init];
        searchVc.typeArray =datalist;
        searchVc.typeId =typeid;
        searchVc.title =titlename;
        if (datalist.count == 0) {
            ALERTSTRING(self.view, @"没有数据")
            return ;
        }
        [self.navigationController pushViewController:searchVc animated:YES];
    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"请求错误")
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
