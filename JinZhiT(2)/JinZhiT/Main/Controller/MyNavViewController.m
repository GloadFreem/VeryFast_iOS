//
//  MyNavViewController.m
//  ChemistsStore
//  Copyright (c) 2015年 Gene. All rights reserved.
//

#import "MyNavViewController.h"

@interface MyNavViewController ()

@end

@implementation MyNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    
//    // Do any additional setup after loading the view.
//    [self.navigationBar setTintColor:[UIColor whiteColor]];
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"矩形-1-拷贝"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    
}
#pragma mark -使用时只调用一次 设置一些全局变量
+(void)initialize{
    //设置局部状态栏布局样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //设置全局导航栏背景
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBJ"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
  
}
/*
-(void)makeDrawerView
{
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width-35, 35)];
    
    baseView.backgroundColor = [UIColor whiteColor];
    self.baseView = baseView;
    
    UILabel *label = [[UILabel alloc]init];
    [baseView addSubview:label];
    label.frame = CGRectMake(0, 0, 150, 35);
    label.text = @"切换类别";
    
    
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width-35, 35)];
    self.drawerView = scroll;
    self.drawerView.backgroundColor = [UIColor grayColor];
    scroll.bounces = NO;
    
    float ItemW = (self.view.width - 35)/5.0f;
    float ItemH = 35;
    NSArray *titleArr = @[@"女装",@"男装",@"鞋履",@"箱包",@"配饰",@"美妆",@"生活"];
    [baseView addSubview:scroll];
    int i = 0;
    for (; i < ClassiesCount ; i++)
    {
        
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        float x = ItemW *i;
        float y = 0;
        float w = ItemW;
        float h = ItemH;
        button.frame = CGRectMake(x, y, w, h);
        [scroll addSubview:button];
        [self.btnArr addObject:button];
        
        
    }
    scroll.contentSize = CGSizeMake(i*ItemW, 0);
    
    
    UIButton *selectBtn = [[UIButton alloc]init];
    selectBtn.frame = CGRectMake(CGRectGetMaxX(scroll.frame), 0, 35, 35);
    [selectBtn setBackgroundColor:[UIColor blackColor]];
    [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:selectBtn];
}
#pragma mark- UI事件
-(void)selectBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.drawerView.bounces = YES;
        CGRect rect = CGRectMake(0, 35, self.view.width, 35*3);
        CGRect baseRect = CGRectMake(0, 0, self.view.width, 35*4);
        float ItemW = self.view.width/3.0f;
        float ItemH = 35;
        int i = 0;
        
        for (UIButton *button in self.btnArr)
        {
            
            float x = ItemW *(i%3);
            float y = ItemH * (i/3);
            float w = ItemW;
            float h = ItemH;
            button.frame = CGRectMake(x, y, w, h);
            //            [self.drawerView addSubview:button];
            i++;
        }
        [self.drawerView setNeedsDisplay];
        self.drawerView.contentSize = CGSizeMake(self.view.width, ItemH * ((i+1)/3));
        [UIView animateWithDuration:0.3 animations:^{
            self.drawerView.frame = rect;
            self.baseView.frame = baseRect;
        }];
    }
    else
    {
        self.drawerView.bounces = NO;
        CGRect rect = CGRectMake(0, 0, self.view.width-35, 35);
        CGRect baseRect = CGRectMake(0, 0, self.view.width, 35);
        float ItemW = (self.view.width - 35)/5.0f;
        float ItemH = 35;
        int i = 0;
        for (UIButton *button in self.btnArr)
        {
            float x = ItemW *i;
            float y = 0;
            float w = ItemW;
            float h = ItemH;
            button.frame = CGRectMake(x, y, w, h);
            //            [self.drawerView addSubview:button];
            i++;
        }
        [self.drawerView setNeedsDisplay];
        [UIView animateWithDuration:0.3 animations:^{
            self.drawerView.frame = rect;
            self.baseView.frame = baseRect;
        }];
        self.drawerView.contentSize = CGSizeMake(i*ItemW, 0);
        
    }
    
}

*/
/*
 导入ZBarSDK文件并引入一下框架
 AVFoundation.framework
 CoreMedia.framework
 CoreVideo.framework
 QuartzCore.framework
 libiconv.dylib
 引入头文件#import “ZBarSDK.h” 即可使用
 */
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
