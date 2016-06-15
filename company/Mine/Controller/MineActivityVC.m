//
//  MineActivityVC.m
//  JinZhiT
//
//  Created by Eugene on 16/5/24.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "MineActivityVC.h"
#import "ActivityCell.h"

#import "ActivityViewModel.h"
#import "MineActivityListModel.h"

#define LOGOACTIVITY @"requestMineAction"

@interface MineActivityVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger page;

@end

@implementation MineActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    self.partner = [TDUtil encryKeyWithMD5:KEY action:LOGOACTIVITY];
    _page = 0;
    
    [self startLoadData];
    
    [self setupNav];
    [self createTableView];
}

#pragma mark -设置导航栏
-(void)setupNav
{
    UIButton * leftback = [UIButton buttonWithType:UIButtonTypeCustom];
    leftback.tag = 2;
    [leftback setBackgroundImage:[UIImage imageNamed:@"leftBack"] forState:UIControlStateNormal];
    leftback.size = leftback.currentBackgroundImage.size;
    [leftback addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftback] ;
    self.navigationItem.title = @"我的活动";
}
#pragma mark -创建tableView
-(void)createTableView
{
    _tableView  = [UITableView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //设置刷新控件
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHttp)];
    //自动改变透明度
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    [_tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(nextPage)];
    
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
}

#pragma mark -刷新控件
-(void)nextPage
{
    _page ++;
    
    [self startLoadData];
    //    NSLog(@"回到顶部");
}

-(void)refreshHttp
{
    _page --;
    if (_page < 0) {
        _page = 0;
    }
    [self startLoadData];
    //    NSLog(@"下拉刷新");
}

-(void)startLoadData
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KEY,@"key",self.partner,@"partner",[NSString stringWithFormat:@"%ld",_page],@"page", nil];
    //开始请求
    [self.httpUtil getDataFromAPIWithOps:LOGO_ACTIVITY_LIST postParam:dic type:0 delegate:self sel:@selector(requestInvestList:)];
}

-(void)requestInvestList:(ASIHTTPRequest *)request
{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
    NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    
    if (_page == 0) {
        [_dataArray removeAllObjects];
    }
    if (jsonDic != nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        if ([status integerValue] == 200) {
            
            
            [self.tableView reloadData];
            //结束刷新
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }else{
            //结束刷新
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [[DialogUtil sharedInstance]showDlg:self.view textOnly:[jsonDic valueForKey:@"message"]];
        
        }
    }
}

#pragma mark -tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"ActivityCell";
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
    }
    [cell.signUpBtn setHidden:YES];
    if (indexPath.row % 2 == 0) {
        [cell.expiredImage setHidden:YES];
        }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -btnAction
-(void)btnClick:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
