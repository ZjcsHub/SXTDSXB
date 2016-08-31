//
//  ZJCButtomView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/30.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PayBlock)();

@interface ZJCButtomView : UIView

@property (nonatomic ,copy) NSString * price;

@property (nonatomic, copy) PayBlock payblock;
@end
