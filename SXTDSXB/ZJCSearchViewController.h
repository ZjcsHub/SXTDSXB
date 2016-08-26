//
//  ZJCSearchViewController.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/24.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZJCSearchViewController : UIViewController

@property (nonatomic, strong)NSArray * dataList;    /** 搜索模型数组 */

@property (nonatomic, strong)NSArray * scrollArray;    /** 无线滚动传来的数组 */
@property (nonatomic, copy) NSString * scrollId;

@property (nonatomic, strong)NSArray * groupArray;    /** 品牌团购数据 */
@property (nonatomic, copy) NSString * ActivityId;    /** 品牌ID */


@property (nonatomic, strong)NSArray * typeArray;    /** 分类进入数据 */
@property (nonatomic, copy) NSString * typeId;


@property (nonatomic, strong)NSArray * butArray;    /** 按钮进入的数据 */
@property (nonatomic, copy) NSString * shopId;
@end
