//
//  model.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/25.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "model.h"
#import "ModelList.h"
@implementation Model

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [ModelList class]
            };
}
@end
