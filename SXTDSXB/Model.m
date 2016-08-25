//
//  model.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/25.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "model.h"

@implementation Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(NSArray *)loadmessage{
    NSArray * datalist =[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ZJCSecond" ofType:@"plist"]];
    NSMutableArray * dataArray =[NSMutableArray array];
    for (NSArray * array in datalist) {
         NSMutableArray * data =[NSMutableArray array];
        for (NSDictionary * dict in array) {
            Model * model =[[Model alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [data addObject:model];
        }
        [dataArray addObject:data];
    }
    
    return dataArray;
}

@end
