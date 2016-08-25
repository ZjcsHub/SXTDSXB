//
//  ZJCSecondViewController.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/17.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCSecondViewController.h"
#import "ZJCFountionCollectionView.h"
@interface ZJCSecondViewController ()

@property (nonatomic, strong)ZJCFountionCollectionView * collection;    /**  */

@end

@implementation ZJCSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.collection];
    __weak typeof (self) weakself =self;
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view).insets(UIEdgeInsetsZero);
    }];
}


- (void)getData{
    [HttpTool getWithPath:@"appBrandarea/asianBrand.do" params:nil success:^(id json) {
        ZJCLog(@"%@",json);
    } failure:^(NSError *error) {
        ZJCLog(@"错误%@",error);
    }];
}

- (ZJCFountionCollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
        NSInteger width = 0;
        if (VIEW_WIDTH == 414) {
            width =(VIEW_WIDTH -6)/5;
        }else{
            width =(VIEW_WIDTH - 5) /4;
        }
        flow.itemSize =CGSizeMake(width, width);
    
        flow.minimumLineSpacing =1;
        flow.minimumInteritemSpacing =1;
//        flow.sectionInset =UIEdgeInsetsMake(40, 1, 0, 1);
        flow.headerReferenceSize =CGSizeMake(VIEW_WIDTH, 40);
        _collection =[[ZJCFountionCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        
    }
    return _collection;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
