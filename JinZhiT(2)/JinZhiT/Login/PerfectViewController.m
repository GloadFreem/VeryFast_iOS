//
//  PerfectViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/5.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "PerfectViewController.h"
#import "RegistSuccessViewController.h"
@interface PerfectViewController ()
@property (weak, nonatomic) IBOutlet UIButton *haveRegist;//完成注册按钮

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btn_Array;//身份按钮数组
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;//头像按钮

@end

@implementation PerfectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
}

-(void)createUI{
    //选择头型按钮属性
    _iconBtn.layer.cornerRadius = 52;
    _iconBtn.layer.masksToBounds = YES;
    _iconBtn.layer.borderWidth = 4;
    _iconBtn.layer.borderColor = [[UIColor colorWithRed:198 green:198 blue:198 alpha:1] CGColor];
    
    //完成注册按钮属性
    _haveRegist.layer.cornerRadius = 20;
    _haveRegist.layer.masksToBounds = YES;
    _haveRegist.layer.borderWidth = 1;
    _haveRegist.layer.borderColor = [[UIColor whiteColor] CGColor];
    //身份按钮属性
    for (UIButton * btn in _btn_Array) {
        btn.layer.cornerRadius = 5;
    }
}
- (IBAction)leftBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)registSuccess:(id)sender {
    RegistSuccessViewController * regist = [RegistSuccessViewController new];
    [self.navigationController pushViewController:regist animated:YES
     ];
}


@end
