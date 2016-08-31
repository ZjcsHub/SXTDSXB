//
//  ZJCOrdertable.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/30.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCOrdertable.h"
#import "DetailModel.h"
#import "GoodsListModel.h"
#import "ZJCOrderTableViewCell.h"
@interface ZJCOrdertable ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZJCOrdertable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self =[super initWithFrame:frame style:style]) {
        self.dataSource =self;
        self.delegate =self;
        self.backgroundColor =[UIColor whiteColor];
        self.tableFooterView =[[UIView alloc] init];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.detailModel.GoodsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier =@"CellId";
    ZJCOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell =[[ZJCOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.goodsModel = self.detailModel.GoodsList[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

@end
