//
//  ZJCThreeButtonView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/24.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddShoppingCarBlock)();

@interface ZJCThreeButtonView : UIView

@property (nonatomic ,copy) AddShoppingCarBlock addBlock;

@end
