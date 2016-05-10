//
//  FindPassWordViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/5.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "FindPassWordViewController.h"
#import "ResetPassWordViewController.h"
@interface FindPassWordViewController ()
@property (weak, nonatomic) IBOutlet UIButton *nextStup;

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
