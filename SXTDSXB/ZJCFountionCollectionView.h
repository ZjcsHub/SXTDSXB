//
//  ZJCFountionCollectionView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/25.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PushNextControllerBlock)(NSString * typeId,NSString * titlename);

@interface ZJCFountionCollectionView : UICollectionView

@property (nonatomic, strong)NSArray * datalist;  

@property (nonatomic, copy) PushNextControllerBlock block;

@end
