//
//  ZJCUserDefaults.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/20.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCUserDefaults.h"

@implementation ZJCUserDefaults

+ (NSUserDefaults *)shareDefault{
    static NSUserDefaults * user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user =[NSUserDefaults standardUserDefaults];
    });
    return user;
}

@end
