//
//  ProjectDetailController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/9.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailController.h"
#import "MeasureTool.h"
#import "ProjectDetailFirstHeaderView.h"   //详情第一段段头View
#import "ProjectDetailBannerView.h"        //详情滚动广告
#import "ProjectDetailScrollCell.h"        //详情团队滚动cell
#import "ProjectDetailBottomCell.h"        //最下边财务报表cell
#import "ProjectDetailFirstMiddleCell.h"   //详情第一段中间隐藏的cell
#import "ProjectDetailMemberCell.h"        //成员cell
#import "ProjectDetailSceneCell.h"         //现场音频cell
#import "ProjectDetailSceneMessageCell.h"  //现场留言cell

#import "ProjectDetailBottomContainerCell.h" //容器 cell
@interface ProjectDetailController ()<UITableViewDataSource,UITableViewDelegate,ProjectDetailBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign, nonatomic) CGFloat cellHeight;

@end

@implementation ProjectDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //广告栏视图
    ProjectDetailBannerView * bannerView= [[ProjectDetailBannerView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH*0.75)];
    //计算cell的高度
    _cellHeight = SCREENHEIGHT - 0.75*SCREENWIDTH;
    
    _tableView.tableHeaderView = bannerView;
    _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    NSArray * arr =[NSArray array];
    [bannerView relayoutWithModelArr:arr];
    bannerView.delegate = self;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent=NO;
    
}

#pragma maek -tableView dataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"ProjectDetailBottomContainerCell";
    ProjectDetailBottomContainerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ProjectDetailBottomContainerCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//#pragma mark- 当显示为  详情分页时 第一段要显示footorView
//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (_selectedCellNum == 1000) {
//        if (section == 0) {
//            NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"更多" ofType:@"png"];
//            CGSize imageSize = [UIImage imageWithContentsOfFile:imagePath].size;
////            NSLog(@"%@",imageSize);
//            UIImage * image = [UIImage imageNamed:@"更多"];
//            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageSize.width, imageSize.height)];
//            imageView.image = image;
//            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, imageSize.height+10)];
//            [btn addSubview:imageView];
//            imageView.center = btn.center;
//            [btn setBackgroundColor:[UIColor redColor]];
//            return btn;
//        }
//    }
//    
//    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
//    return view;
//    
//}
//
//#pragma mark -footor的高度
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (_selectedCellNum == 1000) {
//        if (section == 0) {
//            return 45;
//        }
//        return 0;
//    }
//    return 0;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (_selectedCellNum == 1000) {           //显示 详情分页
//        if (indexPath.section == 0) {         // 第一段 中间默认隐藏的cell
//            static NSString * cellId = @"ProjectDetailFirstMiddleCell";
//            ProjectDetailFirstMiddleCell * cell  = [tableView dequeueReusableCellWithIdentifier:cellId];
//            if (cell == nil) {
//                cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
//            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }else{
//            if (indexPath.row == 0) {          //第二段 第一个 团队cell
//                static NSString * cellId =@"ProjectDetailScrollCell";
//                ProjectDetailScrollCell * cell =[tableView dequeueReusableCellWithIdentifier:cellId];
//                if (cell == nil) {
//                    cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
//                }
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                return cell;
//            }
//            //第二段  第二个 财务报表cell
//            static NSString * cellId = @"ProjectDetailBottomCell";
//            ProjectDetailBottomCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//            if (cell == nil) {
//                cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
//            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//    }else if (_selectedCellNum == 1001){            //显示成员分页
//            static NSString * cellId = @"ProjectDetailMemberCell";
//        ProjectDetailMemberCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
//    
//     //显示现场分页
//    if (indexPath.section == 0) {               //音频播放cell
//        static NSString * cellId = @"ProjectDetailSceneCell";
//        ProjectDetailSceneCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
//    
//   //评论留言cell
//    static NSString * cellId = @"ProjectDetailSceneMessageCell";
//    ProjectDetailSceneMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
//}

//#pragma mark - bannerView 的代理方法
//-(void)transportProjectDetailBannerView:(ProjectDetailBannerView *)view andTagValue:(NSInteger)tagValue
//{
//    _selectedCellNum  = tagValue;//将传过来的tag赋值给_selectedCellNum来决定显示cell的类型
//    
//    //tableView开始更新
//    [_tableView beginUpdates];
////    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
//    [_tableView reloadData];
//    [_tableView endUpdates];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
