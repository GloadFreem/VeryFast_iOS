//
//  SetPassWordViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/5.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "SetPassWordViewController.h"
#import "PerfectViewController.h"
@interface SetPassWordViewController ()
@property (weak, nonatomic) IBOutlet UIButton *leftBackBtn;

@property (weak, nonatomic) IBOutlet UIButton *haveRegist;

@end

@implementation SetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
}

-(void)createUI{
    _haveRegist.layer.cornerRadius = 20;
    _haveRegist.layer.masksToBounds = YES;
    _haveRegist.layer.borderColor = [[UIColor whiteColor] CGColor];
    _haveRegist.layer.borderWidth = 1;
}
- (IBAction)leftBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)haveRegist:(id)sender {
    
    PerfectViewController * perfect =[PerfectViewController new];
    [self.navigationController pushViewController:perfect animated:YES];
    
}

//让当前控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
