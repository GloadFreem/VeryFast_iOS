//
//  ProjectViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/3.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectViewController.h"
#import "ProjectBannerTableViewCell.h"
#import "ProjectListCell.h"
#import "ProjectNoRoadCell.h"
@interface ProjectViewController ()<UITableViewDataSource,UITableViewDelegate,ProjectBannerCellDelegate>

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    
    //这是一个测试 代码
//    、、阿森纳达那看来
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.navigationController.navigationBar.translucent=NO;
}
-(void)createUI
{
    UILabel * titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    titleLabel.text = @"项目";
    [titleLabel setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView=titleLabel;
    
    [self.navigationItem setRightBarButtonItem:[UIBarButtonItem barButtonItemWithIcon:@"组-42" andHeightIcon:@"组-42" Target:self action:@selector(buttonCilck:) andTag:1]];
}

#pragma mark- navigationBar  button的点击事件
-(void)buttonCilck:(UIButton*)button
{
    
}

#pragma mark - tableView datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 237;
    }
    return 172;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString * cellId = @"ProjectBannerTableViewCell";
        ProjectBannerTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[ProjectBannerTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        NSArray * arr =[NSArray array];
        [cell relayoutWithModelArray:arr];
        return cell;
    }
    
    if (indexPath.row ==2 ) {
        static NSString * cellId =@"ProjectNoRoadCell";
        ProjectNoRoadCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString * cellId = @"ProjectListCell";
    ProjectListCell * cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProjectListCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark- ProjectBannerCellDelegate 代理方法
-(void)transportProjectBannerTableViewCell:(ProjectBannerTableViewCell *)cell andTagValue:(NSInteger)tagValue
{
    
}

//让当前控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
