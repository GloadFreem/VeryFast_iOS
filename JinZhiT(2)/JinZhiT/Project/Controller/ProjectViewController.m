//
//  ProjectViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/3.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectViewController.h"
#import "MeasureTool.h"
#import "ProjectBannerTableViewCell.h"
#import "ProjectListCell.h"
#import "ProjectNoRoadCell.h"
#import "ProjectBannerView.h"

@interface ProjectViewController ()<UITableViewDataSource,UITableViewDelegate,ProjectBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger selectedCellNum;

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _selectedCellNum = 20;
    
    ProjectBannerView * bannerView = [[ProjectBannerView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 237)];
    _tableView.tableHeaderView = bannerView;
     NSArray * arr = [NSArray array];
    [bannerView relayoutWithModelArray:arr];
    [bannerView setSelectedNum:20];
    [self createUI];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.navigationController.navigationBar.translucent=NO;
}
-(void)createUI
{
//    UILabel * titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
//    titleLabel.text = @"项目";
//    [titleLabel setTextColor:[UIColor whiteColor]];
//    self.navigationItem.titleView=titleLabel;
    self.navigationItem.title = @"项目";
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
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 237;
//}


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
#pragma mark- ProjectBannerCellDelegate 代理方法
-(void)transportProjectBannerView:(ProjectBannerView *)view andTagValue:(NSInteger)tagValue
{
    _selectedCellNum  = tagValue;
    [_tableView beginUpdates];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"刷新cell");
    [_tableView endUpdates];
}

//让当前控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
