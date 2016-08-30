//
//  PayTypeModel.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/30.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayTypeModel : NSObject

/**支付方式*/
@property (copy, nonatomic) NSString *Distribution;
/**支付名字*/
@property (copy, nonatomic) NSString *DistributionName;


@end
