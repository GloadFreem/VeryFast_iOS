//
//  FindPassWordViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/5.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "ResetPassWordViewController.h"
@interface FindPassWordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *nextStup;//下一步btn
@property (weak, nonatomic) IBOutlet UIButton *getVerifyBtn;//获取验证码btn
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;//手机号textField
@property (weak, nonatomic) IBOutlet UITextField *verifyTextField;//验证码textField

@end

@implementation FindPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
}

-(void)createUI{
    _nextStup.layer.cornerRadius = 20;
    _nextStup.layer.masksToBounds = YES;
    _nextStup.layer.borderColor = [[UIColor whiteColor] CGColor];
    _nextStup.layer.borderWidth = 1;
}
//获取验证码
- (IBAction)getVerify:(UIButton *)sender {
    
}

//返回上一页
- (IBAction)leftBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//下一步
- (IBAction)nextStup:(id)sender {
    ResetPassWordViewController * reset = [ResetPassWordViewController new];
    [self.navigationController pushViewController:reset animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
