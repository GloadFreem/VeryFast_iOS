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
@property (weak, nonatomic) IBOutlet UIButton *haveRegist;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btn_Array;

@end

@implementation PerfectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
}

-(void)createUI{
    _haveRegist.layer.cornerRadius = 20;
    _haveRegist.layer.masksToBounds = YES;
    _haveRegist.layer.borderWidth = 1;
    _haveRegist.layer.borderColor = [[UIColor whiteColor] CGColor];
    
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

//让当前控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
