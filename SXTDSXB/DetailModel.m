//
//  DetailModel.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/30.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "DetailModel.h"
#import "PayTypeModel.h"
#import "GoodsListModel.h"
@implementation DetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"PayList":[PayTypeModel class],
             @"GoodsList":[GoodsListModel class]};
}


@end
