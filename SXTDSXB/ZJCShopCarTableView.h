//
//  ZJCShopCarTableView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/27.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetPriceBlock)();

typedef void(^DeleteBlock)();

@interface ZJCShopCarTableView : UITableView

@property (nonatomic, strong)NSMutableArray * datalist;    /** 模型数组 */

@property (nonatomic, copy) NSString * goodsid;

@property (nonatomic, copy) GetPriceBlock priceBlock;

@property (nonatomic, strong)NSMutableDictionary * heightDict;    /** 高度字典 */

@property (nonatomic, copy) DeleteBlock deleteblock;

@end
