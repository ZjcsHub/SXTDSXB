//
//  ZJCFountionCollectionView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/25.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCFountionCollectionView.h"
#import "ZJCFountionViewCell.h"
#import "Model.h"

static NSString * identifier = @"CellID";
static NSString * reuseIdentifier =@"reuseIdentifier";
@interface ZJCFountionCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSArray * datalist;    /** 模型数组 */

@property (nonatomic, strong)NSArray * stringArray;    /** 字符串数组 */
@end

@implementation ZJCFountionCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self =[super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate =self;
        self.dataSource =self;
        self.backgroundColor =MainColor;
        [self registerClass:[ZJCFountionViewCell class] forCellWithReuseIdentifier:identifier];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier];
    }
    return self;
}
- (NSArray *)stringArray{
    if (!_stringArray) {
        _stringArray =@[@"功效专区",@"面部专区 FASE"];
    }
    return _stringArray;
}

- (NSArray *)datalist{
    if (!_datalist) {
        _datalist =[Model loadmessage];
    }
    return _datalist;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datalist.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray * array =self.datalist[section];
    return array.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJCFountionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSArray * array =self.datalist[indexPath.section];
    Model * model = array[indexPath.item];
    cell.describeLabel.text = model.title;
    cell.goodsType.image =[UIImage imageNamed:model.image];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //判断header,footer
    if (kind == UICollectionElementKindSectionHeader) {
        
        //从缓冲池里获取header
        UICollectionReusableView * reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        UILabel * label =[[UILabel alloc] init];
        label.text =self.stringArray[indexPath.section];
        [reuseView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(reuseView).insets(UIEdgeInsetsMake(0, 15, 0, 0));
        }];
//        reuseView.backgroundColor = [UIColor yellowColor];
        
        return reuseView;
    }
    
    return nil;

}


@end
