//
//  ZJCSearchModel.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/25.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJCSearchModel : NSObject

@property (nonatomic ,copy) NSString * CountryImg;

@property (nonatomic, copy) NSString * ImgView;

@property (nonatomic, copy) NSString * Title;

@property (nonatomic, copy) NSString * Price; /** 现价*/

@property (nonatomic, copy) NSString * DomesticPrice; /** 原价 */

@property (nonatomic, copy) NSString * GoodsId;


@end
