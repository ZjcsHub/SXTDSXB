//
//  DetailTitleView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/23.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DescriptionModel.h"

typedef void(^ReturnHeightBlock)(CGFloat height);

@interface DetailTitleView : UIView

@property (nonatomic,strong) DescriptionModel * descriptionmodel;

@property (nonatomic,copy) ReturnHeightBlock heightblock;

@property (nonatomic,copy) NSString * CountryImg;
@end
