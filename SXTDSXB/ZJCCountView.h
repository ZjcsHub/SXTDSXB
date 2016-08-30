//
//  ZJCCountView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/28.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GoPayBlock)();

@interface ZJCCountView : UIView

@property (nonatomic, strong)NSArray * priceArray;    /** 价格数组 */

@property (nonatomic, copy) GoPayBlock payblock;

@end
