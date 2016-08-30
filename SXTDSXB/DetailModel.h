//
//  DetailModel.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/30.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

/**商品个数*/
@property (copy, nonatomic) NSString *Count;

/**邮费*/
@property (copy, nonatomic) NSString *DeliverCost;

/**支付方式列表*/
@property (strong, nonatomic) NSArray *PayList;

/**订单中商品列表*/
@property (strong, nonatomic) NSArray *GoodsList;
/**订单金额*/
@property (copy, nonatomic) NSString *GoodsPrice;
/**返回信息*/
@property (copy, nonatomic) NSString *Message;
/**是否成功*/
@property (copy, nonatomic) NSString *result;

@property (copy, nonatomic) NSString * Price;
@end
