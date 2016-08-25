//
//  ZJCGoodsListHeaderButton.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/24.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^changeButton)(NSString * string);

@interface ZJCGoodsListHeaderButton : UIView

@property (nonatomic, copy)changeButton changBlock;    /** block */

@end
