//
//  ZJCImageView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/24.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageViewHeightBlock)(CGFloat height);

@interface ZJCImageView : UIView

@property (nonatomic,strong) NSArray * imageArray;

@property (nonatomic,copy) ImageViewHeightBlock heightBlock;
@end
