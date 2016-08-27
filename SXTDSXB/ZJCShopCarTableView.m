//
//  ZJCShopCarTableView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/27.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCShopCarTableView.h"
#import "ZJCShopCarTableViewCell.h"
static NSString * identifier =@"CellId";
@interface ZJCShopCarTableView ()<UITableViewDelegate,UITableViewDataSource>

@end


@implementation ZJCShopCarTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self =[super initWithFrame:frame style:style]) {
        self.delegate =self;
        self.dataSource =self;
       
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJCShopCarTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell =[[ZJCShopCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.carModel = self.datalist[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 81;
}

@end
