//
//  ProjectViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/3.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectViewController.h"
#import "AppDelegate.h"
#import "UIViewController+NavBarHidden.h"
#import "MeasureTool.h"

#import "ProjectListCell.h"
#import "ProjectNoRoadCell.h"
#import "ProjectBannerView.h"
#import "ProjectDetailController.h"
@interface ProjectViewController ()<UITableViewDataSource,UITableViewDelegate,ProjectBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) NSInteger selectedCellNum;//选择显示cell的类型

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.设置当有导航栏自动添加64的高度的属性为NO
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
//
//    [self setKeyScrollView:self.tableView scrolOffsetY:600 options:HYHidenControlOptionTitle];
    
    _selectedCellNum = 20;
    
    ProjectBannerView * bannerView = [[ProjectBannerView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH*0.75+40)];
    [bannerView setSelectedNum:20];
    _tableView.tableHeaderView = bannerView;
     NSArray * arr = [NSArray array];
    [bannerView relayoutWithModelArray:arr];
    
    bannerView.delegate = self;
    [self createUI];
    
    
}
#pragma mark -视图即将显示
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.navigationController.navigationBar.translucent=NO;
}
#pragma mark -视图即将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate * delegate =[UIApplication sharedApplication].delegate;
    
    [delegate.tabBar setHidesBottomBarWhenPushed:YES];
}
-(void)createUI
{
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"项目";
    [titleLabel sizeToFit];
    [titleLabel setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=titleLabel;
   
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem barButtonItemWithIcon:@"message" andHeightIcon:@"message" Target:self action:@selector(buttonCilck:) andTag:1]];
}

#pragma mark- navigationBar  button的点击事件
-(void)buttonCilck:(UIButton*)button
{
    
}

#pragma mark - tableView datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 172;
}



#pragma mark -设置区头
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    ProjectBannerView * bannerView = [[ProjectBannerView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 237)];
//    NSArray * arr = [NSArray array];
//    [bannerView relayoutWithModelArray:arr];
//    [bannerView setSelectedNum:20];
//    return bannerView;
//}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_selectedCellNum == 20) {
        
        static NSString * cellId = @"ProjectListCell";
        ProjectListCell * cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectListCell" owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
        static NSString * cellId =@"ProjectNoRoadCell";
        ProjectNoRoadCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
            
        }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
}

#pragma mark -tableView的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //反选
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProjectDetailController * detail = [[ProjectDetailController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark- ProjectBannerCellDelegate 代理方法
-(void)transportProjectBannerView:(ProjectBannerView *)view andTagValue:(NSInteger)tagValue
{
    _selectedCellNum  = tagValue;//将传过来的tag赋值给_selectedCellNum来决定显示cell的类型
    
    //tableView开始更新
    [_tableView beginUpdates];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    [_tableView endUpdates];
}



@end
