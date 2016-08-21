//
//  ZJCPhoneView.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/18.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCPhoneView.h"
#import "ZJCPhonetest.h"
#define number 60
static NSInteger num =number;
@interface ZJCPhoneView ()<UITextFieldDelegate>



@property (nonatomic, strong) UILabel * backlabel;

@property (nonatomic, strong) UITextField * numberfile;

@property (nonatomic ,strong) UIButton * clinkbutton;

@property (nonatomic, strong) UILabel * linelabel;

//@property (nonatomic, strong) NSMutableAttributedString * string;

@property (nonatomic, strong) dispatch_source_t timer;
@end


@implementation ZJCPhoneView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self addSubview:self.headerlabel];
        [self addSubview:self.backlabel];
        [self addSubview:self.numberfile];
        [self addSubview:self.linelabel];
        [self addSubview:self.timebutton];
        [self addSubview:self.clinkbutton];
        
    }
    return self;
}

- (void)createTimer{
    _timebutton.userInteractionEnabled =NO;
    NSDictionary * dict =@{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    NSDictionary * dict1 =@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.00 green:0.72 blue:0.97 alpha:1.00]};
       NSAttributedString * attbutString =[[NSAttributedString alloc] initWithString:@"请重试" attributes:dict1];
    

    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0* NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
    NSString * numstring = [[NSString stringWithFormat:@"%ld",num] stringByAppendingString:@"秒后重试"];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:numstring attributes:dict];
    NSRange range =[numstring rangeOfString:[NSString stringWithFormat:@"%ld",num]];
    [string addAttributes:dict1 range:range];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_timebutton setAttributedTitle:string forState:UIControlStateNormal];
        });
    
        num--;
        if (num==0) {
            dispatch_source_cancel(self.timer);
            self.timer =nil;
            num = number;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_timebutton setAttributedTitle:attbutString forState:UIControlStateNormal];
            });
            
            _timebutton.userInteractionEnabled =YES;
        }
        
    });
    dispatch_resume(self.timer);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakself =self;
    [_headerlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(weakself);
        make.left.equalTo(weakself).offset(15);
        make.height.equalTo(@43);
    }];
    [_backlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.headerlabel.mas_bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(@43);
    }];
    
    [_numberfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.backlabel.mas_left).offset(15);
        make.top.equalTo(weakself.backlabel.mas_top).offset(1);
        make.bottom.equalTo(weakself.backlabel.mas_bottom).offset(-1);
        make.right.equalTo(weakself.linelabel.mas_left).offset(-10);
    }];
    
    [_linelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.backlabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(1, 30));
        make.right.equalTo(weakself.timebutton.mas_left).offset(-1);
    }];
    [_timebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.backlabel.mas_top).offset(1);
        make.bottom.equalTo(weakself.backlabel.mas_bottom).offset(-1);
        make.right.equalTo(weakself);
        make.width.equalTo(@103);
    }];
    
    [_clinkbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.backlabel.mas_bottom).offset(16);
        make.left.equalTo(weakself).offset(16);
        make.right.equalTo(weakself).offset(-16);
        make.height.equalTo(@35);
    }];
    
}

- (UILabel *)headerlabel{
    if (!_headerlabel) {
        _headerlabel =[[UILabel alloc] init];
        _headerlabel.backgroundColor =MainColor;
     
    }
    return _headerlabel;
}

-(UILabel *)backlabel{
    if (!_backlabel) {
        _backlabel = [[UILabel alloc] init];
        _backlabel.backgroundColor = [UIColor whiteColor];
        _backlabel.layer.borderColor =[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    }
    return _backlabel;
}

- (UITextField *)numberfile{
    if (!_numberfile) {
        _numberfile = [[UITextField alloc] init];
        _numberfile.placeholder =@"请输入验证码";
        _numberfile.delegate =self;
        [_numberfile addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _numberfile;
}

- (UIButton *)timebutton{
    if (!_timebutton) {
        _timebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return _timebutton;
}
- (UILabel *)linelabel{
    if (!_linelabel) {
        _linelabel = [[UILabel alloc] init];
        _linelabel.backgroundColor =MainColor;
    }
    return _linelabel;
}

-(UIButton *)clinkbutton{
    if (!_clinkbutton) {
        _clinkbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clinkbutton setTitle:@"注册" forState:UIControlStateNormal];
        [_clinkbutton setBackgroundColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00]];
        [_clinkbutton setTitleColor:[UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1.00] forState:UIControlStateSelected];
        [_clinkbutton addTarget:self action:@selector(pushNumber) forControlEvents:UIControlEventTouchUpInside];
        _clinkbutton.userInteractionEnabled =NO;
    }
    return _clinkbutton;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location > 5) {
        return NO;
    }
    return YES;
}

- (void)valueChange:(UITextField *)textfile{
    if (textfile.text.length==6) {
        [_clinkbutton setBackgroundColor:[UIColor colorWithRed:0.00 green:0.71 blue:0.98 alpha:1.00]];
        _clinkbutton.userInteractionEnabled =YES;
    }else{
         [_clinkbutton setBackgroundColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00]];
        _clinkbutton.userInteractionEnabled =NO;
    }
}

- (void)pushNumber{
    if (_pushBlock) {
        _pushBlock(self.numberfile.text);
    }
}

@end
