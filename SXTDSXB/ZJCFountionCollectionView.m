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
#import "ModelList.h"
#import "CollectionHeaderView.h"
static NSString * identifier = @"CellID";
static NSString * reuseIdentifier =@"reuseIdentifier";
@interface ZJCFountionCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSArray * imageArray;    /** 图片数组 */

@end

@implementation ZJCFountionCollectionView

- (NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray =[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ZJCSecond" ofType:@"plist"]];
        
    }
    return _imageArray;
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self =[super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate =self;
        self.dataSource =self;
        self.backgroundColor =MainColor;
        [self registerClass:[ZJCFountionViewCell class] forCellWithReuseIdentifier:identifier];
        [self registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier];
    }
    return self;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datalist.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    Model * model =self.datalist[section];
    return model.list.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZJCFountionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Model * model =self.datalist[indexPath.section];
    ModelList * list =model.list[indexPath.item];
    cell.describeLabel.text = list.Title;
    
    cell.goodsType.image =[UIImage imageNamed:[self.imageArray[arc4random_uniform((unsigned)self.imageArray.count)] objectForKey:@"image"]];
   
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //判断header,footer
    if (kind == UICollectionElementKindSectionHeader) {
        
        //从缓冲池里获取header
        CollectionHeaderView * reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        
        reuseView.nameLabel.text =[self.datalist[indexPath.section] Title];
        return reuseView;
    }
    
    return nil;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Model * model =self.datalist[indexPath.section];
    ModelList * list =model.list[indexPath.item];
    NSString * typeid =list.TypeId;
    NSString * titleName = list.Title;
    if (_block) {
        _block(typeid,titleName);
    }
    
}



@end
