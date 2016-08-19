//
//  ZJCtableView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/17.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCtableView.h"
#import "ZJCTableViewCell.h"
#import "ZJCHeaderView.h"
@interface ZJCtableView ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation ZJCtableView


- (NSMutableArray *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray arrayWithArray:@[@"我的收藏",@"意见反馈",@"关于我们",@"客服热线"]];
    }
    return _datalist;
}

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        UIImage * image1 =[UIImage imageNamed:@"我的界面我的收藏图标"];
        UIImage * image2 =[UIImage imageNamed:@"我的界面意见反馈图标"];
        UIImage * image3 =[UIImage imageNamed:@"我的界面关于我们图标"];
        UIImage * image4 =[UIImage imageNamed:@"我的界面客服热线图标"];
        _imageArray =[NSMutableArray arrayWithArray:@[image1,image2,image3,image4]];
    }
    return _imageArray;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self =[super initWithFrame:frame style:style]) {
        self.delegate =self;
        self.dataSource =self;
        [self.datalist addObjectsFromArray:@[@"我的优惠劵",@"邀请好友,一块赚钱"]];
        [self.imageArray addObjectsFromArray:@[[UIImage imageNamed:@"我的界面我的优惠券图标"],[UIImage imageNamed:@"我的界面邀请好友图标"]]];
    }
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier =@"cell";
    ZJCTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell =[[ZJCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    if ([self.datalist[indexPath.row] isEqualToString:@"客服热线"]) {
        UILabel * textlabel =[[UILabel alloc] init];
        textlabel.textAlignment = NSTextAlignmentRight;
        textlabel.text =@"400-6010-545";
        [cell addSubview:textlabel];
        textlabel.font =[UIFont systemFontOfSize:14];
        [textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.right.equalTo(@-15);
            make.size.mas_equalTo(CGSizeMake(110, cell.frame.size.height));
        }];
        cell.iconView.image =self.imageArray[indexPath.row];
        cell.namelabel.text =self.datalist[indexPath.row];
    }else{
        cell.nextimage.image =[UIImage imageNamed:@"下一步"];
        cell.iconView.image =self.imageArray[indexPath.row];
        cell.namelabel.text =self.datalist[indexPath.row];
    }
    return cell;
}




@end
