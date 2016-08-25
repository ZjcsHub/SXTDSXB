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
#import "DescriptionModel.h"
#import "DetailTitleView.h"
#import "ZJCDetailModel.h"
#import "ZJCDetailView.h"
#import "ZJCImageView.h"
#import "ZJCThreeButtonView.h"

@interface ZJCDetailGoodsController ()

@property (nonatomic,strong) UIScrollView * scrollview;

@property (nonatomic,strong) NSArray * imageArray;

@property (nonatomic,strong) ZJCCycleScrollView * cyclescrollView;

@property (nonatomic,strong) DetailTitleView * detailtitleview;

@property (nonatomic,strong) ZJCDetailView * detailView;

@property (nonatomic,strong) ZJCImageView * imageView;

@property (nonatomic,assign) CGFloat scrollViewContentSizeHeight;

@property (nonatomic, strong)ZJCThreeButtonView * buttonView;    /** 三个按钮的视图 */
@end

@implementation ZJCDetailGoodsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =MainColor;
    self.edgesForExtendedLayout =0;
    self.scrollViewContentSizeHeight =380;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsCompact];
    [self.view addSubview:self.scrollview];
    [self.view addSubview:self.buttonView];
    [self.scrollview addSubview:self.cyclescrollView];
    [self.scrollview addSubview:self.detailtitleview];
    [self.scrollview addSubview:self.detailView];
    [self.scrollview addSubview:self.imageView];
    __weak typeof (self) weakself =self;
    [_scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view).with.insets(UIEdgeInsetsMake(0, 0, 45, 0));
    }];
    [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakself.view);
        make.top.equalTo(weakself.scrollview.mas_bottom);
    }];
    [_detailtitleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.cyclescrollView.mas_bottom);
        make.right.left.equalTo(weakself.view);
    }];
    [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.detailtitleview.mas_bottom);
        make.right.left.equalTo(weakself.view);

    }];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.detailView.mas_bottom);
        make.left.right.equalTo(weakself.view);
    }];
    [self requestGoodsidImageData];
    [self requestDataDetailData];
    [self getDataPriceAndDequest];
}
/**
 *  头部滚动数据
 */
- (void)requestGoodsidImageData{
    [HttpTool getWithPath:@"appGoods/findGoodsImgList.do" params:@{@"GoodsId":self.goodsid} success:^(id json) {
        NSArray * datalist =[NSArray yy_modelArrayWithClass:[ImageModel class] json:json];
        NSMutableArray * imageArray =[NSMutableArray array];
        for (ImageModel * model in datalist) {
            if ([model.ImgType isEqualToString:@"1"]) {
                [imageArray addObject:model.ImgView];
            }
        }
        self.cyclescrollView.imageArray =imageArray;
        
        _imageView.imageArray = datalist;
        
    } failure:^(NSError *error) {
        
    }];
}
/**
 *   商品详细信息
 */
- (void)requestDataDetailData{
    [HttpTool getWithPath:@"appGoods/findGoodsDetailList.do" params:@{@"GoodsId":self.goodsid} success:^(id json) {
        //
        NSArray * datalist = [NSArray yy_modelArrayWithClass:[ZJCDetailModel class] json:json];
        _detailView.modellist =datalist;
        
    } failure:^(NSError *error) {
        //
    }];
}
/**
 * 名称价格列表数据请求
 */
- (void)getDataPriceAndDequest{
    [HttpTool getWithPath:@"appGoods/findGoodsDetail.do" params:@{@"GoodsId":self.goodsid} success:^(id json) {
        //
        DescriptionModel * descriptionmodel = [DescriptionModel yy_modelWithDictionary:json];
        _detailtitleview.descriptionmodel = descriptionmodel;
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
        _scrollview.contentSize =CGSizeMake(0, 1000);
    }
    return _scrollview;
}

- (DetailTitleView *)detailtitleview{
    if (!_detailtitleview) {
        _detailtitleview = [[DetailTitleView alloc] init];
        _detailtitleview.CountryImg =self.CountryImg;
        __weak typeof (self) weakself =self;
        _detailtitleview.heightblock = ^(CGFloat height){
          [weakself.detailtitleview mas_makeConstraints:^(MASConstraintMaker *make) {
              make.height.mas_equalTo(height);
          }];
            weakself.cyclescrollView.buylabel.text = weakself.detailtitleview.buycount;
            
            weakself.scrollViewContentSizeHeight +=height;
            
        };
    }
    return _detailtitleview;
}
- (ZJCDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[ZJCDetailView alloc] init];
        __weak typeof (self) weakself =self;
        _detailView.heightBlock =^(CGFloat height){
            [weakself.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
       
            weakself.scrollViewContentSizeHeight +=height;
        };
    }
    return _detailView;
}

- (ZJCImageView *)imageView{
    if (!_imageView) {
        _imageView =[[ZJCImageView alloc] initWithFrame:CGRectZero];
        __weak typeof (self) weakself =self;
        _imageView.heightBlock = ^(CGFloat height){
            [weakself.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
            weakself.scrollViewContentSizeHeight +=height;
        };
    }
    return _imageView;
}

- (ZJCThreeButtonView *)buttonView{
    if (!_buttonView) {
        _buttonView = [[ZJCThreeButtonView alloc] init];
    }
    return _buttonView;
}

- (void)setScrollViewContentSizeHeight:(CGFloat)scrollViewContentSizeHeight{
    _scrollViewContentSizeHeight =scrollViewContentSizeHeight;
     _scrollview.contentSize =CGSizeMake(0, _scrollViewContentSizeHeight);
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
