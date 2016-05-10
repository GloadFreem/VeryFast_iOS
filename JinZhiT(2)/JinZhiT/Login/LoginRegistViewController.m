//
//  LoginRegistViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/4.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "LoginRegistViewController.h"
#import "RegisterViewController.h"
#import "FindPassWordViewController.h"
@interface LoginRegistViewController ()


@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *noBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;

@end

@implementation LoginRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
    
    
}

-(void)createUI{
    //头像
    _iconBtn.layer.cornerRadius = 52;
    _iconBtn.layer.masksToBounds = YES;
    _iconBtn.layer.borderWidth = 4;
    _iconBtn.layer.borderColor = [[UIColor grayColor] CGColor];
}
//没有账号
- (IBAction)noBtn:(id)sender {
    
    RegisterViewController * registerVC = [RegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
//忘记密码
- (IBAction)forgetPassWord:(id)sender {
    FindPassWordViewController * find =[FindPassWordViewController new];
    [self.navigationController pushViewController:find animated:YES];
}
- (IBAction)weChatBtn:(UIButton *)sender {
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//让当前控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
