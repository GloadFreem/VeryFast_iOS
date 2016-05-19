//
//  ActivityDetailVC.m
//  JinZhiT
//
//  Created by Eugene on 16/5/19.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ActivityDetailVC.h"

@interface ActivityDetailVC ()

@end

@implementation ActivityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    AppDelegate * delegate =[UIApplication sharedApplication].delegate;
    
    [delegate.tabBar tabBarHidden:NO animated:NO];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
