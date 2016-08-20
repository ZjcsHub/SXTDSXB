//
//  ZJCtableView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/17.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJCtableView : UITableView
@property (nonatomic ,strong) NSMutableArray * datalist;

@property (nonatomic ,strong) NSMutableArray * imageArray;

@property (nonatomic, assign) BOOL hidden;
@end
