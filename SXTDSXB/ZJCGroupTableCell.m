//
//  ZJCGroupTableCell.h
//  ZJC
//
//  Created by 赵继超 on 16/8/22.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCGroupTableCell.h"
@interface ZJCGroupTableCell()
@property (strong, nonatomic)   UIImageView *groupImage;              /** 团购展示图片 */
@end

@implementation ZJCGroupTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.groupImage];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    [_groupImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
}

- (void)setImageUrl:(NSString *)ImageUrl{
    [_groupImage downloadImage:ImageUrl placeholder:@"屏幕快照 2016-08-22 11.25.54.png"];
}

- (UIImageView *)groupImage{
    if (!_groupImage) {
        _groupImage = [[UIImageView alloc]init];
    }
    return _groupImage;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
