//
//  ResetPassWordViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/5.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ResetPassWordViewController.h"

@interface ResetPassWordViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *certainBtn;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondField;

@end

@implementation ResetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
}

-(void)createUI{
    //确定按钮的属性
    _certainBtn.layer.cornerRadius = 20;
    _certainBtn.layer.masksToBounds = YES;
    _certainBtn.layer.borderWidth = 1;
    _certainBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
}
//返回按钮
- (IBAction)leftBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//确定按钮
- (IBAction)certainBtn:(UIButton *)sender {
}


@end
