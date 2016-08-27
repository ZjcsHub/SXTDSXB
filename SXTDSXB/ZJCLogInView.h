//
//  ZJCLogInView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/20.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PoptoBackBlock)(NSDictionary * dict);

typedef void(^PushToNextViewBlock)();
@interface ZJCLogInView : UIView

@property(nonatomic,strong) PoptoBackBlock block;

@property(nonatomic,copy) PushToNextViewBlock pushblock;
@end
