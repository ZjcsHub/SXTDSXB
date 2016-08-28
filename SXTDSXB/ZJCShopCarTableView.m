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
        self.estimatedRowHeight = 100;
        self.tableFooterView =[[UIView alloc] init];
        self.backgroundColor =MainColor;
    }
    return self;
}

- (NSMutableDictionary *)heightDict{
    if (!_heightDict) {
        _heightDict =[NSMutableDictionary dictionary];
    }
    return _heightDict;
}
- (NSMutableArray *)datalist{
    if (!_datalist) {
        _datalist =[NSMutableArray array];
    }
    return _datalist;
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
    if (!self.heightDict[indexPath]) {
        self.heightDict[indexPath] = @(cell.cellheight);
    }
    __weak typeof (cell) weakcell =cell;
    __weak typeof (self) weakself =self;
    cell.addNum = ^(NSString * goodsid){
        NSString * number =weakcell.numlabel.text;
        weakcell.numlabel.text = [NSString stringWithFormat:@"%ld",[number integerValue] + 1];
        [weakself addShoppingCarNumber:goodsid];
    };
    cell.reduceNum = ^(NSString * uuid,NSString * goodscount){
        NSString * number =weakcell.numlabel.text;
        if([number integerValue] == 1){
            weakcell.numlabel.text = [NSString stringWithFormat:@"%d",1];
            return;
        }
        weakcell.numlabel.text = [NSString stringWithFormat:@"%ld",[number integerValue] - 1];
        [weakself changeShoppingCarNumber:uuid BuyCount:weakcell.numlabel.text];
    };
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.heightDict[indexPath] doubleValue];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        ZJCShopCarTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        [self changeShoppingCarNumber:cell.carModel.UUID BuyCount:@"0"];
               [self.datalist removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
        if (self.datalist.count == 0) {
            if (_deleteblock) {
                _deleteblock();
            }
        }
    }
}





- (void)changeShoppingCarNumber:(NSString *)uuid BuyCount:(NSString *)count{
    
    NSString * updateString =[uuid stringByAppendingString:@","];
    updateString =[updateString stringByAppendingString:count];
    
    [HttpTool getWithPath:@"appShopCart/appUpdateCart.do" params:@{@"updateCartMsg":updateString} success:^(id json) {
        ZJCLog(@"修改成功");
        if (_priceBlock) {
            _priceBlock();
        }
    } failure:^(NSError *error) {
        ZJCLog(@"error,%@",error);
    }];
}

- (void)addShoppingCarNumber:(NSString *)goodsid{
    NSDictionary * dict =[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginData"];
    [HttpTool getWithPath:@"appShopCart/insert.do" params:@{@"MemberId":dict[@"MemberId"],@"GoodsId":goodsid} success:^(id json) {
        ZJCLog(@"%@",json);
        if (_priceBlock) {
            _priceBlock();
        }
    } failure:^(NSError *error) {
        ZJCLog(@"%@",error);
    }];
}


@end
