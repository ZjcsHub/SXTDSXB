//
//  model.h
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/25.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * image;

+(NSArray *)loadmessage;

@end