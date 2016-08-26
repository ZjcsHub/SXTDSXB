//
//  CollectionHeaderView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/26.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "CollectionHeaderView.h"

@interface CollectionHeaderView ()
@end


@implementation CollectionHeaderView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.nameLabel];
        __weak typeof (self) weakself =self;
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakself).insets(UIEdgeInsetsMake(0, 15, 0, 0));
        }];

    }
    return self;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel =[[UILabel alloc] init];
        
    }
    return _nameLabel;
}

@end
