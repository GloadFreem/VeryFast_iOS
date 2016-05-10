//
//  RegisterViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/5.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "RegisterViewController.h"
#import "SetPassWordViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark --- leftBackBtn  Action
- (IBAction)leftBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --- registBtn   Action
//注册按钮点击时间
- (IBAction)registClick:(id)sender {
    
    SetPassWordViewController * set = [SetPassWordViewController new];
    [self.navigationController pushViewController:set animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//让当前控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
