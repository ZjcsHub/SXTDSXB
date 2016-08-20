//
//  ZJCHeaderView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/17.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PushBlock)();

typedef void(^PushTologinViewBlock)();

@interface ZJCHeaderView : UIView

@property (nonatomic,copy) PushBlock pushblock;

@property (nonatomic,copy) PushTologinViewBlock loginViewblock;
@end
