//
//  MineViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/21.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "MineViewController.h"
#import "MoneyAccountVC.h"
#import "MineAttentionVC.h"
@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [self.navigationController.navigationBar setHidden:NO];
}
#pragma mark -进入头像详情页面
- (IBAction)iconDetail:(UIButton *)sender {
}

#pragma mark -进入各个小界面
- (IBAction)btnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
        {
            MoneyAccountVC *vc = [MoneyAccountVC new];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            MineAttentionVC *vc = [MineAttentionVC new];
            [self.navigationController  pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            NSLog(@"点击了第%ld个",sender.tag);
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
        case 7:
        {
            
        }
            break;
        default:
            break;
    }

}

#pragma mark -退出logo界面
- (IBAction)closeView:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
