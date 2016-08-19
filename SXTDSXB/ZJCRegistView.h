//
//  ZJCRegistView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/18.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^phoneBlock)(NSDictionary * dict);

@interface ZJCRegistView : UIView

@property (nonatomic, copy) phoneBlock block;

@end
