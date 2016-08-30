//
//  ZJCCollectionView.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/24.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PushToDetailViewBlock)(NSString * goodsid,NSString * imageName,NSString * title);

@interface ZJCCollectionView : UICollectionView

@property (nonatomic, strong)NSArray * datalist;    /** 模型数组 */

@property (nonatomic, copy) PushToDetailViewBlock pushBlock;
@end
