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
@interface ZJCTimeViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView * mainScrollView;

@property (nonatomic,strong) SDCycleScrollView * headscrollView;

@property (nonatomic,strong) ZJCTwoBUttonView * twobuttonView;

@property (nonatomic,strong) ZJCTimetableView * singletable;

@property (nonatomic,strong) ZJCTimetableView * grouptable;

@property (strong, nonatomic)   NSArray *singleModelArray;              /** 存放新品数据模型的数组 */
@property (strong, nonatomic)   NSArray *groupModelArray;/**存放团购数据模型的数组*/


@end

@implementation ZJCTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.headscrollView];
    [self.mainScrollView addSubview:self.singletable];
    [self.mainScrollView addSubview:self.grouptable];
    [self.mainScrollView addSubview:self.twobuttonView];
    [self makesinglenetwork];
    [self requestGroupData];
}

#pragma mark - 新品团购网络请求
- (void)makesinglenetwork{
    [HttpTool getWithPath:@"appActivity/appHomeGoodsList.do" params:nil success:^(id json) {
        self.singleModelArray = [NSArray yy_modelArrayWithClass:[ZJCSingleModel class] json:json];
        
       _singletable.signalarray =self.singleModelArray;
        CGRect tableViewRect = _singletable.frame;
        tableViewRect.size.height = self.singletable.signalarray.count * 170;
        _singletable.frame = tableViewRect;
       
        

        if (_twobuttonView.button1.selected) {
            _mainScrollView.contentSize = CGSizeMake(0, self.singletable.signalarray.count * 170 + 280);
        }
        
        [_singletable reloadData];

    } failure:^(NSError *error) {
        ALERTSTRING(self.view, @"网络请求错误")
        ZJCLog(@"%@",error);
    }];
}

//请求团购数据
- (void)requestGroupData{
    [HttpTool getWithPath:@"appActivity/appActivityList.do" params:nil success:^(id json) {
    self.groupModelArray = [NSArray yy_modelArrayWithClass:[ZJCGroupListModel class] json:json];
    _grouptable.grouparray = self.groupModelArray;
    CGRect tableViewRect = _grouptable.frame;
    tableViewRect.size.height = _groupModelArray.count * 200;
    _grouptable.frame = tableViewRect;
    if (_twobuttonView.button2.selected) {
        _mainScrollView.contentSize = CGSizeMake(0, _singleModelArray.count * 200 + 280);
    }
    [_grouptable reloadData];
} failure:^(NSError *error) {
    
}];
}


- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        _mainScrollView.contentSize =CGSizeMake(0, MAXFLOAT);
        _mainScrollView.bounces =NO;
        _mainScrollView.delegate =self;
    }
    return _mainScrollView;
}
- (SDCycleScrollView *)headscrollView{
    if (!_headscrollView) {
        _headscrollView =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,VIEW_WIDTH,230) delegate:nil placeholderImage:[UIImage imageNamed:@"屏幕快照 2016-08-22 11.25.54"]];
        _headscrollView.backgroundColor =[UIColor blueColor];
        _headscrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headscrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        
        //         --- 模拟加载延迟
    NSMutableArray * imagesURLStrings = [NSMutableArray array];
    [HttpTool getWithPath:@"appHome/appHome.do" params:nil success:^(id json) {
            
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
    }
    return _singletable;
}

- (ZJCTimetableView *)grouptable{
    if (!_grouptable) {
        _grouptable =[[ZJCTimetableView alloc] initWithFrame:CGRectMake(VIEW_WIDTH, 280, VIEW_WIDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
        _grouptable.isSingal =NO;
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
            _mainScrollView.contentSize = CGSizeMake(0, _singleModelArray.count * 170 + 280);
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
            _mainScrollView.contentSize = CGSizeMake(0, _singleModelArray.count * 200 + 280);
        }];
    }
}

#pragma mark - ScrollView-Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
 
    if (scrollView.contentOffset.y >230-64) {
        CGRect rect = _twobuttonView.frame;
        rect.origin.y = scrollView.contentOffset.y + 64;
        _twobuttonView.frame =rect;
    }else{
        CGRect rect = _twobuttonView.frame;
        rect.origin.y = 230;
        _twobuttonView.frame =rect;
    }
}
//- (void)tableViewchange:(UIButton *)button{
//    if (button == _button1) {
//        [UIView animateWithDuration:0.5 animations:^{
//            CGRect tableRect1 = _tableView1.frame;
//            tableRect1.origin.x =0;
//            _tableView1.frame =tableRect1;
//            
//            CGRect tableRect2 =_tableView2.frame;
//            tableRect2.origin.x = VIEW_WIDTH;
//            _tableView2.frame =tableRect2;
//        }];
//    }else if (button == _button2){
//        [UIView animateWithDuration:0.5 animations:^{
//            CGRect tableRect1 = _tableView1.frame;
//            tableRect1.origin.x =-VIEW_WIDTH;
//            _tableView1.frame =tableRect1;
//            
//            CGRect tableRect2 =_tableView2.frame;
//            tableRect2.origin.x = 0;
//            _tableView2.frame =tableRect2;
//        }];
//    }
//}



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
