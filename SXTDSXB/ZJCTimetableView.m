//
//  ZJCTimetableView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/22.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCTimetableView.h"
#import "ZJCsingleCell.h"
#import "ZJCGroupTableCell.h"
@interface ZJCTimetableView ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation ZJCTimetableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate =self;
        self.dataSource =self;
        self.bounces =NO;
    }
    return self;
}
- (NSMutableArray *)signalarray{
    if (!_signalarray) {
        _signalarray =[NSMutableArray array];
    }
    return _signalarray;
}
- (NSMutableArray *)grouparray{
    if (!_grouparray) {
        _grouparray  =[NSMutableArray array];
    }
    return _grouparray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isSingal) {
        return self.signalarray.count;
    }else{
        return self.grouparray.count;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isSingal) {
        return 170;
    }else
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isSingal) {
        static NSString * identifer =@"cell";
        ZJCsingleCell * cell =[tableView dequeueReusableCellWithIdentifier:identifer];
        if (!cell) {
            cell =[[ZJCsingleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        cell.singleModel = self.signalarray[indexPath.row];
        return cell;
    }else{
        static NSString * identifier2 =@"identifier";
        ZJCGroupTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (!cell) {
            cell = [[ZJCGroupTableCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier2];
        }
        cell.model =self.grouparray[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_idBlock) {
        _idBlock([self.signalarray[indexPath.row] GoodsId],[self.signalarray[indexPath.row] CountryImg]);
    }
    if (_IDBlock) {
        
        _IDBlock([self.grouparray[indexPath.row] ActivityId]);
    }
}

@end
