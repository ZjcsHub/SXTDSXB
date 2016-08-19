//
//  ZJCPhoneView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/18.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PushnumberBlock)(NSString * code);

@interface ZJCPhoneView : UIView
@property (nonatomic, strong) UILabel * headerlabel;
@property (nonatomic, strong) UIButton * timebutton;
@property (nonatomic, copy) PushnumberBlock pushBlock;
- (void)createTimer;
@end
