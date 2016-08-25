//
//  NSAttributedString+ZJCPriceString.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/25.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "NSAttributedString+ZJCPriceString.h"

@implementation NSAttributedString (ZJCPriceString)

+ (NSAttributedString *)returnFirstString:(NSString *)firststring lastString:(NSString *)laststring{
    NSMutableAttributedString * NewPrice =[[NSMutableAttributedString alloc] initWithString:firststring attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor colorWithRed:1.00 green:0.00 blue:0.00 alpha:1.00]}];
    NSMutableAttributedString * oldPrice =[[NSMutableAttributedString alloc] initWithString:laststring attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1.00],NSStrikethroughStyleAttributeName:@1}];
    [NewPrice insertAttributedString:oldPrice atIndex:NewPrice.length];
    return NewPrice;
}


@end
