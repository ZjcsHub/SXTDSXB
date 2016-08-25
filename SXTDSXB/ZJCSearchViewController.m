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
@interface ZJCSearchViewController ()

@property (nonatomic, strong)UISearchBar * searchbar;    /** 搜索栏 */
@property (nonatomic, strong)ZJCGoodsListHeaderButton * goodBtnView;    /** 按钮视图 */
@property (nonatomic, strong)ZJCCollectionView * collectionView;    /** collection视图 */
@end

@implementation ZJCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =MainColor;
    
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
            [weakself getData:string];
        };
    }
    return _goodBtnView;
}

- (void)getData:(NSString *)string{
    [HttpTool postWithPath:@"appSearch/searchList.do" params:@{@"search":self.title,@"OrderName":string,@"OrderType":@"ASC"} success:^(id json) {
        ZJCLog(@"%@",json);
        NSArray * dataList =[NSArray yy_modelArrayWithClass:[ZJCSearchModel class] json:json];
         _collectionView.datalist=dataList;
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        
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
        _collectionView.datalist =self.dataList;
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
