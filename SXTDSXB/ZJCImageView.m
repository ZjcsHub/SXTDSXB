//
//  ZJCImageView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/24.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCImageView.h"
#import "ImageModel.h"
@implementation ZJCImageView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor whiteColor];
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray{
    _imageArray =imageArray;
    CGFloat imageviewHeight = 0;
    for (ImageModel * model in imageArray) {
        if ([model.ImgType isEqualToString:@"1"]) {
            NSArray * size = [model.Resolution componentsSeparatedByString:@"*"];
            CGFloat height =VIEW_WIDTH *[size[1] floatValue]/[size[0] floatValue];
            UIImageView * imageview =[[UIImageView alloc] initWithFrame:CGRectMake(0, imageviewHeight, VIEW_WIDTH,height)];
            [imageview sd_setImageWithURL:[NSURL URLWithString:model.ImgView]];
            imageviewHeight += height;
            [self addSubview:imageview];
        }
    }
    if (_heightBlock) {
        _heightBlock(imageviewHeight);
    }
    
}


@end
