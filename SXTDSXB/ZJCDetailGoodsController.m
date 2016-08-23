//
//  ZJCDetailGoodsController.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/23.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCDetailGoodsController.h"
#import "ZJCCycleScrollView.h"
#import "ImageModel.h"
@interface ZJCDetailGoodsController ()

@property (nonatomic,strong) UIScrollView * scrollview;

@property (nonatomic,strong) NSArray * imageArray;

@property (nonatomic,strong) ZJCCycleScrollView * cyclescrollView;
@end

@implementation ZJCDetailGoodsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =MainColor;
    self.edgesForExtendedLayout =0;
    [self.view addSubview:self.scrollview];
    [self.scrollview addSubview:self.cyclescrollView];
    __weak typeof (self) weakself =self;
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view).with.insets(UIEdgeInsetsMake(0, 0, 45, 0));
    }];
    
    [self requestGoodsidImageData];
    [self requestDataDetailData];
    [self getDataPriceAndDequest];
    ZJCLog(@"%@",self.goodsid);
}
/**
 *  头部滚动数据
 */
- (void)requestGoodsidImageData{
    [HttpTool getWithPath:@"appGoods/findGoodsImgList.do" params:@{@"GoodsId":self.goodsid} success:^(id json) {
        NSArray * datalist =[NSArray yy_modelArrayWithClass:[ImageModel class] json:json];
        ZJCLog(@"%@",json);
        NSMutableArray * imageArray =[NSMutableArray array];
        for (ImageModel * model in datalist) {
            if ([model.ImgType isEqualToString:@"1"]) {
                [imageArray addObject:model.ImgView];
            }
        }
        self.cyclescrollView.imageArray =imageArray;
        
        
    } failure:^(NSError *error) {
        
    }];
}
/**
 *  名称价格列表数据请求
 */
- (void)requestDataDetailData{
    [HttpTool getWithPath:@"appGoods/findGoodsDetailList.do" params:@{@"GoodsId":self.goodsid} success:^(id json) {
        //
        ZJCLog(@"名称列表 %@",json);
    } failure:^(NSError *error) {
        //
    }];
}
/**
 *  商品详细信息
 */
- (void)getDataPriceAndDequest{
    [HttpTool getWithPath:@"appGoods/findGoodsDetail.do" params:@{@"GoodsId":self.goodsid} success:^(id json) {
        //
        ZJCLog(@"详细信息 %@",json);
    } failure:^(NSError *error) {
        //
    }];
}


- (ZJCCycleScrollView *)cyclescrollView{
    if (!_cyclescrollView) {
        _cyclescrollView =[[ZJCCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 380)];
    }
    return _cyclescrollView;
}

- (UIScrollView *)scrollview{
    if (!_scrollview) {
        _scrollview =[[UIScrollView alloc] init];
    }
    return _scrollview;
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
