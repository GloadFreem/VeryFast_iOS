//
//  MoneyAccountVC.m
//  JinZhiT
//
//  Created by Eugene on 16/5/23.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "MoneyAccountVC.h"
#import "DealBillVC.h"
@interface MoneyAccountVC ()

@end

@implementation MoneyAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //自定义nav
//    [self setupNav];
}

#pragma mark -返回上一页
- (IBAction)leftClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -btnClick
- (IBAction)btnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
//            DealBillVC *vc = [DealBillVC new];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
    
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
#pragma mark- 自定义nav
-(void)setupNav
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:color(25, 177, 158, 1)];
    UIView *statusBar = [[UIView alloc]initWithFrame:CGRectMake(0, -20, SCREENWIDTH, 20)];
    [statusBar setBackgroundColor:color(25, 177, 158, 1)];
    [self.navigationController.navigationBar addSubview:statusBar];
}

@end
