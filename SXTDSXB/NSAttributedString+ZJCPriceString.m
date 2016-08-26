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
    
    NSString * string =[@" ￥" stringByAppendingString:laststring];
    NSMutableAttributedString * NewPrice =[[NSMutableAttributedString alloc] initWithString:firststring attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor colorWithRed:1.00 green:0.00 blue:0.00 alpha:1.00]}];
    NSMutableAttributedString * oldPrice =[[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1.00],NSStrikethroughStyleAttributeName:@1}];
    [NewPrice insertAttributedString:oldPrice atIndex:NewPrice.length];
    return NewPrice;
}

+ (NSAttributedString *)returnNexPrice:(NSString *)newPrice OldPrice:(NSString *)oldPrice Distence:(NSString *)distence{
    NSMutableAttributedString * NewPrice =[[NSMutableAttributedString alloc] initWithString:newPrice attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor colorWithRed:1.00 green:0.00 blue:0.00 alpha:1.00]}];
    NSMutableAttributedString * oldstring =[[NSMutableAttributedString alloc] initWithString:oldPrice attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1.00],NSStrikethroughStyleAttributeName:@1}];
    CGFloat dis = [distence floatValue]*10;
    NSString * string =[NSString stringWithFormat:@"(%.1f折)",dis];
    NSMutableAttributedString * dist = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [oldstring insertAttributedString:dist atIndex:oldstring.length];
    [NewPrice insertAttributedString:oldstring atIndex:NewPrice.length];
    return NewPrice;
}


@end
