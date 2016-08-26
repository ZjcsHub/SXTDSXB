//
//  NSAttributedString+ZJCPriceString.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/25.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (ZJCPriceString)

+ (NSAttributedString *)returnFirstString:(NSString *)firststring lastString:(NSString *)laststring;

+ (NSAttributedString *)returnNexPrice:(NSString *)newPrice OldPrice:(NSString *)oldPrice Distence:(NSString *)distence;

@end
