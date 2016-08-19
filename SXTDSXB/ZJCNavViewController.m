//
//  ZJCNavViewController.m
//  SXTDSXB
//
//  Created by 赵继超 on 16/8/17.
//  Copyright © 2016年 赵继超. All rights reserved.
//

#import "ZJCNavViewController.h"

@interface ZJCNavViewController ()

@end

@implementation ZJCNavViewController

+(void)initialize{
    UINavigationBar * navbar =[UINavigationBar appearance];
    [navbar setBackgroundImage:[UIImage imageNamed:@"nav_backImage"] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count) {
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"详情界面返回按钮"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(returnlastController) forControlEvents:UIControlEventTouchUpInside];
//        button.frame = CGRectMake(0, 0, 30, 30);
       
        viewController.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
        [button sizeToFit];
        viewController.hidesBottomBarWhenPushed =YES;
    }
    [super pushViewController:viewController animated:YES];
}

- (void)returnlastController{
    [self popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
