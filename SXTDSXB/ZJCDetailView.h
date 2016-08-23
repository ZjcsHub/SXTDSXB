//
//  ZJCDetailView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/23.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJCDetailModel.h"

typedef void(^ChangeViewHeightBlock)(CGFloat height);

@interface ZJCDetailView : UIView

@property (nonatomic,strong) NSArray * modellist;

@property (nonatomic,copy) ChangeViewHeightBlock heightBlock;

@end
