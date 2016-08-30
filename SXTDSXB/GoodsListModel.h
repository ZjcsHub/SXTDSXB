//
//  GoodsListModel.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/30.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsListModel : NSObject

@property (nonatomic, copy)NSString * DomesticPrice;    /** 折扣前价格 */
@property (nonatomic, copy)NSString * Weight;    /** 重量 */
@property (nonatomic, copy)NSString * Abbreviation;    /** 品牌名 */
@property (nonatomic, copy)NSString * GoodsCount;    /** 商品数量 */
@property (nonatomic, copy)NSString * Price;    /** 当前价格 */
@property (nonatomic, copy)NSString * GoodsId;    /** 商品Id */
@property (nonatomic, copy)NSString * ImgView;    /** 商品图片 */
@property (nonatomic, copy)NSString * PriceAndCount;

@end
