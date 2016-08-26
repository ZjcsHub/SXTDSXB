//
//  ZJCTimetableView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/22.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^newTableViewSelectGoodsIdBlock)(NSString * goodid,NSString * countryName);

typedef void(^newTbaleViewSelectiGroupBlock)(NSString * ActivityId);

@interface ZJCTimetableView : UITableView

@property (nonatomic,assign) BOOL isSingal;

@property (nonatomic,strong) NSMutableArray * signalarray;

@property (nonatomic,strong) NSMutableArray * grouparray;

@property (nonatomic,copy) newTableViewSelectGoodsIdBlock idBlock;

@property (nonatomic, copy)newTbaleViewSelectiGroupBlock IDBlock;    /**  */
@end
