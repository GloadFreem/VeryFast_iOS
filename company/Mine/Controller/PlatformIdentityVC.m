//
//  PlatformIdentityVC.m
//  JinZhiT
//
//  Created by Eugene on 16/5/25.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "PlatformIdentityVC.h"

@interface PlatformIdentityVC ()

@end

@implementation PlatformIdentityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupNav];
}

#pragma mark -设置导航栏
-(void)setupNav
{
    UIButton * leftback = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftback setBackgroundImage:[UIImage imageNamed:@"leftBack"] forState:UIControlStateNormal];
    leftback.size = leftback.currentBackgroundImage.size;
    [leftback addTarget:self action:@selector(leftBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftback] ;
    self.navigationItem.title = @"平台身份";
}
#pragma mark- 返回按钮
-(void)leftBack:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
