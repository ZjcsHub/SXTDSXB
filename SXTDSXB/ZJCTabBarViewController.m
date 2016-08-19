//
//  ZJCTabBarViewController.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/17.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCTabBarViewController.h"
#import "ZJCTimeViewController.h"
#import "ZJCSecondViewController.h"
#import "ZJCThirdViewController.h"
#import "ZJCFourthViewController.h"
#import "ZJCNavViewController.h"
@interface ZJCTabBarViewController ()

@end

@implementation ZJCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.01 green:0.71 blue:0.98 alpha:1.00]} forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1.00]} forState:UIControlStateNormal];
    ZJCTimeViewController * time =[[ZJCTimeViewController alloc] init];
    time.tabBarItem.image =[UIImage imageNamed:@"菜单栏限时特卖按钮未选中状态"];
    time.tabBarItem.selectedImage =[UIImage imageNamed:@"菜单栏限时特卖按钮选中状态"];
    ZJCNavViewController * nav1 =[[ZJCNavViewController alloc] initWithRootViewController:time];
    time.title =@"限时购";
    
    ZJCSecondViewController * second = [[ZJCSecondViewController alloc] init];
    second.tabBarItem.image =[UIImage imageNamed:@"菜单栏分类按钮未选中状态"];
    second.tabBarItem.selectedImage =[UIImage imageNamed:@"菜单栏分类按钮选中状态"];
    ZJCNavViewController * nav2 =[[ZJCNavViewController alloc] initWithRootViewController:second];
    second.title =@"分类";
    
    ZJCThirdViewController * third = [[ZJCThirdViewController alloc] init];
    third.tabBarItem.image =[UIImage imageNamed:@"菜单栏购物车按钮未选中状态"];
    third.tabBarItem.selectedImage =[UIImage imageNamed:@"菜单栏购物车按钮选中状态"];
    ZJCNavViewController * nav3 =[[ZJCNavViewController alloc] initWithRootViewController:third];
    third.title =@"购物车";
    
    ZJCFourthViewController * fourth =[[ZJCFourthViewController alloc] init];
    fourth.tabBarItem.image =[UIImage imageNamed:@"菜单栏我的按钮未选中状态"];
    fourth.tabBarItem.selectedImage =[UIImage imageNamed:@"菜单栏我的按钮选中状态"];
    ZJCNavViewController * nav4 =[[ZJCNavViewController alloc] initWithRootViewController:fourth];
    fourth.title =@"我";
    
    self.viewControllers =@[nav1,nav2,nav3,nav4];

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
