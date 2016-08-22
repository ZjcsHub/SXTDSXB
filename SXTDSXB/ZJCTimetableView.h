//
//  ZJCTimetableView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/22.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJCTimetableView : UITableView

@property (nonatomic,assign) BOOL isSingal;

@property (nonatomic,strong) NSMutableArray * signalarray;

@property (nonatomic,strong) NSMutableArray * grouparray;

@end
