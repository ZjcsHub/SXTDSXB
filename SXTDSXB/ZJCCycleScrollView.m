//
//  ZJCCycleScrollView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/23.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCCycleScrollView.h"

@interface ZJCCycleScrollView ()

@property (nonatomic,strong) SDCycleScrollView * headscrollView;

@end


@implementation ZJCCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.headscrollView];
        [self addSubview:self.buylabel];
        __weak typeof (self) weakself =self;
       
        [_buylabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakself.mas_bottom).offset(-35);
            make.right.equalTo(weakself.mas_right).offset(11);
            make.size.mas_equalTo(CGSizeMake(100, 22));
        }];
        
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray{
    _imageArray =imageArray;

    _headscrollView.imageURLStringsGroup = imageArray;
}
- (SDCycleScrollView *)headscrollView{
    if (!_headscrollView) {
        _headscrollView =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,VIEW_WIDTH,380) delegate:nil placeholderImage:[UIImage imageNamed:@"background"]];
        _headscrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headscrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页
    }
    return _headscrollView;
}

- (UILabel *)buylabel{
    if (!_buylabel) {
        _buylabel =[[UILabel alloc] init];
        _buylabel.text= @"100人已购买";
        _buylabel.backgroundColor =[UIColor colorWithRed:1.00 green:0.16 blue:0.00 alpha:1.00];
        _buylabel.textColor =[UIColor colorWithRed:1.00 green:0.92 blue:0.89 alpha:1.00];
        _buylabel.layer.masksToBounds =YES;
        _buylabel.layer.cornerRadius =11;
        _buylabel.textAlignment = NSTextAlignmentCenter;
        _buylabel.font =[UIFont systemFontOfSize:12];
    }
    return _buylabel;
}


@end
