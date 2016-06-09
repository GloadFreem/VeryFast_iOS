//
//  Renzheng2ViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/6.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "Renzheng2ViewController.h"
#import "Renzheng3ViewController.h"

@interface Renzheng2ViewController ()


@property (weak, nonatomic) IBOutlet UIButton *imageBtn;


@end

@implementation Renzheng2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)leftBack:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextStupClick:(UIButton *)sender {
    Renzheng3ViewController * regist = [Renzheng3ViewController new];
    [self.navigationController pushViewController:regist animated:YES];
}


//让当前控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
