//
//  MineAttentionVC.m
//  JinZhiT
//
//  Created by Eugene on 16/5/23.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "MineAttentionVC.h"
#import "ProjectListCell.h"
#import "ProjectNoRoadCell.h"
@interface MineAttentionVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIButton *projectBtn;    //
@property (nonatomic, strong) UIButton *investBtn;    //

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *projectTableView;  //项目视图
@property (nonatomic, assign) NSInteger selectedTableView;  //选择要加载的视图
@property (nonatomic, strong) UITableView *investTableView;  //投资视图

@end

@implementation MineAttentionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _selectedTableView = 0;  //默认显示第一个视图
    //创建基本布局
    [self setupNav];
    [self createUI];
    
}
#pragma mark -导航栏设置
-(void)setupNav
{
    
    UIButton * leftback = [UIButton buttonWithType:UIButtonTypeCustom];
    leftback.tag = 2;
    [leftback setBackgroundImage:[UIImage imageNamed:@"leftBack"] forState:UIControlStateNormal];
    leftback.size = leftback.currentBackgroundImage.size;
    [leftback addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftback] ;
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 144, 30)];
    titleView.layer.cornerRadius = 5;
    titleView.layer.masksToBounds = YES;
    titleView.layer.borderColor = [UIColor whiteColor].CGColor;
    titleView.layer.borderWidth = 0.5;
    _titleView = titleView;
    
    UIButton *projectBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [projectBtn setTitle:@"项目" forState:UIControlStateNormal];
    [projectBtn setTag:0];
    [projectBtn setTitle:@"项目" forState:UIControlStateSelected];
    [projectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [projectBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    projectBtn.titleLabel.font = BGFont(14);
    [projectBtn setBackgroundColor:[UIColor whiteColor]];
    [titleView addSubview:projectBtn];
    _projectBtn = projectBtn;
    
    [projectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleView.mas_left);
        make.top.mas_equalTo(titleView.mas_top);
        make.bottom.mas_equalTo(titleView.mas_bottom);
        make.right.mas_equalTo(titleView.mas_centerX);
    }];
    
    UIButton *investBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [investBtn setTag:1];
    [investBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [investBtn setTitle:@"投资" forState:UIControlStateNormal];
    [investBtn setTitle:@"投资" forState:UIControlStateSelected];
    [investBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    investBtn.titleLabel.font = BGFont(14);
    [investBtn setBackgroundColor:color(61, 69, 78, 1)];
    [titleView addSubview:investBtn];
    _investBtn = investBtn;
    
    [investBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(projectBtn.mas_right);
        make.top.mas_equalTo(projectBtn.mas_top);
        make.bottom.mas_equalTo(projectBtn.mas_bottom);
        make.right.mas_equalTo(titleView.mas_right);
    }];
    
    self.navigationItem.titleView = titleView;
    
    
}
#pragma mark -titleView  button点击事件
-(void)btnClick:(UIButton*)btn
{
  
    if (btn.tag == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    

        if (btn.tag == 0) {
            [_projectBtn setBackgroundColor:[UIColor whiteColor]];
            [_projectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [_investBtn setBackgroundColor:color(61, 69, 78, 1)];
            [_investBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        if (btn.tag == 1) {
            [_investBtn setBackgroundColor:[UIColor whiteColor]];
            [_investBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [_projectBtn setBackgroundColor:color(61, 69, 78, 1)];
            [_projectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    _selectedTableView = btn.tag;
    _scrollView.contentOffset = CGPointMake(SCREENWIDTH*btn.tag, 0);
    [self loadData];
    
    }
}

#pragma mark -scrollView的滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == _scrollView) {
        
        CGFloat offSetX = scrollView.contentOffset.x;
        NSInteger index = offSetX/SCREENWIDTH;
        //当前选中tableView
        _selectedTableView = index;
        //重置btn的颜色
        if (index == 0) {
            [_projectBtn setBackgroundColor:[UIColor whiteColor]];
            [_projectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [_investBtn setBackgroundColor:color(61, 69, 78, 1)];
            [_investBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        if (index == 1) {
            [_investBtn setBackgroundColor:[UIColor whiteColor]];
            [_investBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [_projectBtn setBackgroundColor:color(61, 69, 78, 1)];
            [_projectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
       
        //下载数据
        [self loadData];
        
        switch (index) {
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
                
                
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark -下载数据
-(void)loadData
{
    if (_selectedTableView == 0) {
        [_projectTableView reloadData];
    }
    if (_selectedTableView == 1) {
        [_investTableView reloadData];
    }
    
}

-(void)createUI
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64)];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH*2, 0);
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    //方向锁
    _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:_scrollView];
    
    _projectTableView = [UITableView new];
    [self createTableView:_projectTableView index:0];
//    [_projectTableView setBackgroundColor:[UIColor redColor]];
    
    _investTableView = [UITableView new];
    [self createTableView:_investTableView index:1];
//    [_investTableView setBackgroundColor:[UIColor greenColor]];
}


#pragma mark -UItableVlewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_selectedTableView == 0) {
        return 5;
    }
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedTableView == 0) {
        return 172;
    }
//    return 113;
    return 172;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedTableView == 0) {
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark- 创建tableView
-(void)createTableView:(UITableView*)tableView index:(int)index
{
    tableView.frame=CGRectMake(index*SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - 64);
    //    分隔线隐藏
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tag = index;
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
