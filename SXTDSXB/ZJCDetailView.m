//
//  ZJCDetailView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/23.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCDetailView.h"

@interface ZJCDetailView ()



@end

@implementation ZJCDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
    }
    return self;
}

- (void)setModellist:(NSArray *)modellist{
    _modellist =modellist;
    CGFloat height = 0;
    for (ZJCDetailModel * model in modellist) {
        UILabel * namelabel = [[UILabel alloc] initWithFrame:CGRectMake(16, height, 70, 34)];
        namelabel.font =[UIFont systemFontOfSize:14];
        namelabel.text = [model.Title stringByAppendingString:@":"];
        [self addSubview:namelabel];
        
        
        
        UILabel * valueLabel =[[UILabel alloc] initWithFrame:CGRectMake(90, height+10, VIEW_WIDTH -100, height)];
        valueLabel.text =model.Value;
        CGFloat Labelheight = [self getLabelsHeight:valueLabel.text prame:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        valueLabel.frame = CGRectMake(90, height+10, VIEW_WIDTH -100, Labelheight);
        valueLabel.numberOfLines =0;
        valueLabel.font =[UIFont systemFontOfSize:14];
        [self addSubview:valueLabel];
        
        height = height + Labelheight + 34;
    }
    if (_heightBlock) {
        _heightBlock(height);
    }
}

/**
 *  获取label的高度
 */
- (CGFloat)getLabelsHeight:(NSString *)string prame:(NSDictionary *)dict{
    CGFloat height =[string boundingRectWithSize:CGSizeMake(VIEW_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    return height;
}



@end
