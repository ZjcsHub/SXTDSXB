//
//  ZJCShopCarTableViewCell.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/27.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJCShopCarModel.h"

typedef void(^AddNumberBlock)(NSString * goodid);

typedef void(^ReduceNumberBlock)(NSString * uuid,NSString * goodsCount);

typedef void(^ButtonSelectBlock)();

@interface ZJCShopCarTableViewCell : UITableViewCell

@property (nonatomic, strong)ZJCShopCarModel * carModel;    /** 模型 */

@property (nonatomic, assign)CGFloat cellheight;    /** cell的高度 */

@property (nonatomic, copy) AddNumberBlock addNum;

@property (nonatomic, copy) ReduceNumberBlock reduceNum;

@property (nonatomic, strong)UILabel * numlabel;    /** 数字label */

@property (nonatomic, copy) ButtonSelectBlock selectBlock;
@end
