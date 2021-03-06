//
//  ZJCTimeViewController.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/17.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCTimeViewController.h"
#import "ZJCTwoBUttonView.h"
#import "ZJCTimetableView.h"
#import "ZJCSingleModel.h"
#import "ZJCGroupListModel.h"
#import "ZJCDetailGoodsController.h"
#import "ZJCSearchViewController.h"
#import "ZJCSearchModel.h"
@interface ZJCTimeViewController ()<UIScrollViewDelegate,UISearchBarDelegate,SDCycleScrollViewDelegate>

@property (nonatomic,strong) UIScrollView * mainScrollView;

@property (nonatomic,strong) SDCycleScrollView * headscrollView;

@property (nonatomic,strong) ZJCTwoBUttonView * twobuttonView;

@property (nonatomic,strong) ZJCTimetableView * singletable;

@property (nonatomic,strong) ZJCTimetableView * grouptable;

@property (strong, nonatomic)   NSArray *singleModelArray;              /** 存放新品数据模型的数组 */
@property (strong, nonatomic)   NSArray *groupModelArray;/**存放团购数据模型的数组*/
@property (nonatomic, strong)UISearchBar * searchBar;    /** 搜索栏 */

@property (nonatomic, strong) UIButton * searchBun;    /** 按钮 */

@property (nonatomic, strong)NSArray * scrollArray;    /** 无线滚动数据源 */
@end

@implementation ZJCTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainScrollView];
    self.edgesForExtendedLayout =0;
    _searchBun = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchBun setBackgroundImage:[UIImage imageNamed:@"限时特卖界面搜索按钮"] forState:UIControlStateNormal];
    [_searchBun addTarget:self action:@selector(pushNextController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:_searchBun];
    [_searchBun sizeToFit];
    [self.mainScrollView addSubview:self.headscrollView];
    [self.mainScrollView addSubview:self.singletable];
    [self.mainScrollView addSubview:self.grouptable];
    [self.mainScrollView addSubview:self.twobuttonView];
    [self makesinglenetwork];
    [self requestGroupData];
}

- (void)pushNextController{

    self.navigationItem.rightBarButtonItem =nil;
    self.navigationItem.titleView = self.searchBar;
    [_searchBar becomeFirstResponder];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_searchBar resignFirstResponder];
    self.navigationItem.titleView = nil;
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:_searchBun];
}

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar =[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH-40, 25)];
        _searchBar.showsCancelButton =YES;
        _searchBar.delegate =self;
    }
    return _searchBar;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    self.navigationItem.titleView = nil;
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:_searchBun];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [HttpTool postWithPath:@"appSearch/searchList.do" params:@{@"search":searchBar.text,@"OrderName":@"host",@"OrderType":@"ASC"} success:^(id json) {
        NSArray * dataList =[NSArray yy_modelArrayWithClass:[ZJCSearchModel class] json:json];
        if (dataList.count==0) {
            ALERTSTRING(self.view, @"未查找到数据，请重新输入")
            return ;
        }
        ZJCSearchViewController * searchVc =[[ZJCSearchViewController alloc] init];
        searchVc.dataList = dataList;
        searchVc.title = searchBar.text;
        [searchBar resignFirstResponder];
        [self.navigationController pushViewController:searchVc animated:YES];
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 新品团购网络请求
- (void)makesinglenetwork{
    [HttpTool getWithPath:@"appActivity/appHomeGoodsList.do" params:nil success:^(id json) {
        self.singleModelArray = [NSArray yy_modelArrayWithClass:[ZJCSingleModel class] json:json];
        
        [_singletable.signalarray addObjectsFromArray:self.singleModelArray];
        CGRect tableViewRect = _singletable.frame;
        tableViewRect.size.height = _singletable.signalarray.count * 170;
        _singletable.frame = tableViewRect;
        if (_twobuttonView.button1.selected) {
            _mainScrollView.contentSize = CGSizeMake(0, self.singletable.signalarray.count * 170 + 280);
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [_singletable reloadData];
        }];
        

    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"网络请求错误")
    }];
}

//请求团购数据
- (void)requestGroupData{
    [HttpTool getWithPath:@"appActivity/appActivityList.do" params:nil success:^(id json) {
    self.groupModelArray = [NSArray yy_modelArrayWithClass:[ZJCGroupListModel class] json:json];
    [_grouptable.grouparray addObjectsFromArray:self.groupModelArray];
    CGRect tableViewRect = _grouptable.frame;
    tableViewRect.size.height = _grouptable.grouparray.count * 200;
    _grouptable.frame = tableViewRect;
    if (_twobuttonView.button2.selected) {
        _mainScrollView.contentSize = CGSizeMake(0, _grouptable.grouparray.count * 200 + 280);
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [_grouptable reloadData];

    }];
} failure:^(NSError *error) {
    ALERTSTRING(self.view, @"网络请求错误")
}];
}


- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-64-49)];
        _mainScrollView.contentSize =CGSizeMake(0, MAXFLOAT);
        _mainScrollView.bounces =NO;
        _mainScrollView.delegate =self;
        _mainScrollView.showsVerticalScrollIndicator = NO;
    }
    return _mainScrollView;
}
- (SDCycleScrollView *)headscrollView{
    if (!_headscrollView) {
        _headscrollView =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,VIEW_WIDTH,230) delegate:nil placeholderImage:[UIImage imageNamed:@"background.png"]];
        _headscrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headscrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        _headscrollView.delegate =self;
        //         --- 模拟加载延迟
    NSMutableArray * imagesURLStrings = [NSMutableArray array];
    [HttpTool getWithPath:@"appHome/appHome.do" params:nil success:^(id json) {
        self.scrollArray = json;
            for (NSDictionary * dict in json) {
                NSString * URLString = dict[@"ImgView"];
                [imagesURLStrings addObject:URLString];
            }
        _headscrollView.imageURLStringsGroup = imagesURLStrings;
        } failure:^(NSError *error) {
            
        }];
    }
    return _headscrollView;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSString * string = [self.scrollArray[index] objectForKey:@"RelatedId"];
    [HttpTool getWithPath:@"appGgroupon/appGrounpGoodsList.do" params:@{@"GrouponId":string,@"OrderName":@"host",@"OrderType":@"ASC"} success:^(id json) {
        NSArray * datalist =[NSArray yy_modelArrayWithClass:[ZJCSearchModel class] json:json];
        ZJCSearchViewController * searchVc =[[ZJCSearchViewController alloc] init];
        searchVc.scrollArray = datalist;
        searchVc.scrollId =string;
       searchVc.title =@"推荐";
        if (datalist.count == 0) {
            ALERTSTRING(self.view, @"没有数据")
            return ;
        }
        [self.navigationController pushViewController:searchVc animated:YES];
    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"网络请求错误")
    }];
}


- (ZJCTwoBUttonView *)twobuttonView{
    if (!_twobuttonView) {
        _twobuttonView = [[ZJCTwoBUttonView alloc]initWithFrame:CGRectMake(0, 230, VIEW_WIDTH, 50)];
        _twobuttonView.backgroundColor = [UIColor whiteColor];
        [_twobuttonView.button2 addTarget:self action:@selector(changeTableFrame:) forControlEvents:(UIControlEventTouchUpInside)];
        [_twobuttonView.button1 addTarget:self action:@selector(changeTableFrame:) forControlEvents:(UIControlEventTouchUpInside)];
        }
    return _twobuttonView;
}

- (ZJCTimetableView *)singletable{
    if (!_singletable) {
        _singletable =[[ZJCTimetableView alloc] initWithFrame:CGRectMake(0, 280, VIEW_WIDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
        _singletable.isSingal =YES;
        __weak typeof (self) weakself =self;
        _singletable.idBlock = ^(NSString * goodsid,NSString * countryName){
            ZJCDetailGoodsController * goodsID =[[ZJCDetailGoodsController alloc] init];
            goodsID.goodsid =goodsid;
            goodsID.CountryImg =countryName;
            goodsID.title =@"新品团购";
            
            [weakself.navigationController pushViewController:goodsID animated:YES];
        };
    }
    return _singletable;
}

- (ZJCTimetableView *)grouptable{
    if (!_grouptable) {
        _grouptable =[[ZJCTimetableView alloc] initWithFrame:CGRectMake(VIEW_WIDTH, 280, VIEW_WIDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
        _grouptable.isSingal =NO;
        __weak typeof (self) weakself =self;
        _grouptable.IDBlock =^(NSString * ActivityId){
            [weakself getGroupData:ActivityId];
        };
    }
    return _grouptable;
}

- (void)changeTableFrame:(UIButton *)button{
    
    if (button == _twobuttonView.button1) {
        button.selected = YES;
        _twobuttonView.button2.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect tableRect1 = _singletable.frame;
            tableRect1.origin.x = 0;
            _singletable.frame = tableRect1;
            
            CGRect tableRect2 = _grouptable.frame;
            tableRect2.origin.x = VIEW_WIDTH;
            _grouptable.frame = tableRect2;
            _mainScrollView.contentSize = CGSizeMake(0, _singletable.signalarray.count * 170 + 280);
        }];
    }else {
        button.selected = YES;
        _twobuttonView.button1.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect tableRect1 = _singletable.frame;
            tableRect1.origin.x = -VIEW_WIDTH;
            _singletable.frame = tableRect1;
            
            CGRect tableRect2 = _grouptable.frame;
            tableRect2.origin.x = 0;
            _grouptable.frame = tableRect2;
            _mainScrollView.contentSize = CGSizeMake(0, _grouptable.grouparray.count * 200 + 280);
        }];
    }
}

#pragma mark - ScrollView-Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
 
    if (scrollView.contentOffset.y >230) {
        CGRect rect = _twobuttonView.frame;
        rect.origin.y = scrollView.contentOffset.y ;
        _twobuttonView.frame =rect;
    }else{
        CGRect rect = _twobuttonView.frame;
        rect.origin.y = 230;
        _twobuttonView.frame =rect;
    }
}

- (void)getGroupData:(NSString *)ActivityId{
    [HttpTool getWithPath:@"appGgroupon/appGrounpGoodsList.do" params:@{@"GrouponId":ActivityId,@"OrderName":@"host",@"OrderType":@"ASC"}  success:^(id json) {
        NSArray * datalist =[NSArray yy_modelArrayWithClass:[ZJCSearchModel class] json:json];
        ZJCSearchViewController * searchVc =[[ZJCSearchViewController alloc] init];
        searchVc.groupArray =datalist;
        searchVc.ActivityId =ActivityId;
        searchVc.title =@"品牌团购";
        if (datalist.count == 0) {
            ALERTSTRING(self.view, @"没有数据")
            return ;
        }
        [self.navigationController pushViewController:searchVc animated:YES];
        
    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"网络请求错误")
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
