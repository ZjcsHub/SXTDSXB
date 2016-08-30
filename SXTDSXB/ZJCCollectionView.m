//
//  ZJCCollectionView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/24.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCCollectionView.h"
#import "CollectionCell.h"
#import "ZJCSearchModel.h"

@interface ZJCCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation ZJCCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self =[super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate =self;
        self.dataSource=self;
        self.backgroundColor =MainColor;
        [self registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"identifier"];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datalist.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"identifier" forIndexPath:indexPath];
    
    cell.model =self.datalist[indexPath.item];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_pushBlock) {
        _pushBlock([self.datalist[indexPath.item] GoodsId],[self.datalist[indexPath.item] CountryImg],[self.datalist[indexPath.item] Title]);
    }
}





@end
