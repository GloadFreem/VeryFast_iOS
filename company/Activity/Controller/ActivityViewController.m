//
//  ActivityViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/3.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityCell.h"
#import "ActivityDetailVC.h"
#import "ActivityViewModel.h"
#import "ActivityBlackCoverView.h"
@interface ActivityViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ActivityViewDelegate,ActivityBlackCoverViewDelegate>

@property (nonatomic,assign)id attendInstance; //回复
@property (nonatomic, assign) NSInteger page; 
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString * actionListPartner;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化tableView
    [self createTableView];
    //初始化搜索框
    [self createSearchView];
    
    //生成请求partner
    self.actionListPartner = [TDUtil encryKeyWithMD5:KEY action:ACTION_LIST];
    
    self.page = 0;
    //加载数据
    [self loadActionListData];
    
}

/**
 *  获取活动列表
 */

-(void)loadActionListData
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KEY,@"key",self.actionListPartner,@"partner",STRING(@"%ld", self.page),@"page", nil];
    //开始请求
    [self.httpUtil getDataFromAPIWithOps:ACTION_LIST postParam:dic type:0 delegate:self sel:@selector(requestActionList:)];
}

-(void)requestActionList:(ASIHTTPRequest*)request
{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
    NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    if (jsonDic != nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        if ([status integerValue] == 200) {
            NSArray *dataArray = [NSArray arrayWithArray:jsonDic[@"data"]];
            NSMutableArray * array = [[NSMutableArray alloc] init];
            
            //解析
            NSDictionary *dataDic;
            ActivityViewModel * baseModel;
            for (int i=0; i<dataArray.count; i++) {
                dataDic = dataArray[0];
                baseModel = [ActivityViewModel mj_objectWithKeyValues:dataDic];
                [array addObject:baseModel];
            }
            
            //设置数据模型
            self.dataSourceArray = array;
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    }
}

-(void)setDataSourceArray:(NSMutableArray *)dataSourceArray
{
    _dataSourceArray = dataSourceArray;
    if(_dataSourceArray.count>0)
    {
        //刷新数据
        [self.tableView reloadData];
    }
}

#pragma mark -初始化 tableView
-(void)createTableView
{
    _tableView = [[UITableView alloc]init];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置刷新控件
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadActionListData)];
    //自动改变透明度
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadActionListData)];
    
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];

}

-(void)createSearchView
{
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-20, 29)];
    field.placeholder = @"互联网金融黑马预测。。。";
    field.backgroundColor = [UIColor whiteColor];
    field.textColor = [UIColor blackColor];
    field.font = [UIFont systemFontOfSize:15];
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.borderStyle = UITextBorderStyleNone;
    field.clearsOnBeginEditing = YES; //再次编辑清空
    field.keyboardType = UIKeyboardTypeDefault;
    field.returnKeyType = UIReturnKeyDone;
    field.delegate =self;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.backgroundColor = [UIColor colorWithRed:253/255.0 green:133/255.0 blue:0 alpha:1];
    searchBtn.frame = CGRectMake(0, 0, 49, 29);
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTag:0];
    field.rightView = searchBtn;
    field.rightViewMode = UITextFieldViewModeAlways;
    
    [self.navigationItem setTitleView:field];
    
}
#pragma mark -tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ActivityCell";
    ActivityCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil] lastObject];
        cell.delegate = self;
    }
    cell.model = [_dataSourceArray objectAtIndex:indexPath.row];
//    [cell.expiredImage setHidden:NO];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //反选
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActivityDetailVC * vc = [ActivityDetailVC new];
    
    
    ActivityViewModel * model = [_dataSourceArray objectAtIndex:indexPath.row];
    vc.activityModel = model;
    
    
    //隐藏tabbar
    AppDelegate * delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [delegate.tabBar tabBarHidden:YES animated:NO];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -btnAction
-(void)searchBtnClick:(UIButton*)btn
{
    if (btn.tag == 0) {
        NSLog(@"开始搜索");
    }
}

#pragma mark- UItextField的代理方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
//已经开始编辑
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
//已经结束编辑
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma ActivityDelegate
-(void)attendAction:(id)model
{
    self.attendInstance = model;
    
    ActivityBlackCoverView * attendView = [ActivityBlackCoverView instancetationActivityBlackCoverView];
    attendView.delegate = self;
    attendView.tag = 1000;
    [self.view addSubview:attendView];
    
}

#pragma ActivityBlackCoverViewDelegate
-(void)clickBtnInView:(ActivityBlackCoverView *)view andIndex:(NSInteger)index content:(NSString *)content
{
    if (index==0) {
        [view removeFromSuperview];
    }else{
        //确定
        [self attendActionWithContent:content];
    }
}

/**
 *  报名
 */

-(void)attendActionWithContent:(NSString*)content
{
    NSString * parthner = [TDUtil encryKeyWithMD5:KEY action:ATTEND_ACTION];
    
    ActivityViewModel * modle = (ActivityViewModel*)self.attendInstance;
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KEY,@"key",parthner,@"partner",content,@"content",STRING(@"%ld", modle.actionId),@"contentId", nil];
    //开始请求
    [self.httpUtil getDataFromAPIWithOps:ATTEND_ACTION postParam:dic type:0 delegate:self sel:@selector(requestAttendAction:)];
}

-(void)requestAttendAction:(ASIHTTPRequest*)request
{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
    NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    if (jsonDic != nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        if ([status integerValue] == 200) {
//            NSArray *dataArray = [NSArray arrayWithArray:jsonDic[@"data"]];
//            NSMutableArray * array = [[NSMutableArray alloc] init];
//            
//            //解析
//            NSDictionary *dataDic;
//            ActivityViewModel * baseModel;
//            for (int i=0; i<dataArray.count; i++) {
//                dataDic = dataArray[0];
//                baseModel = [ActivityViewModel mj_objectWithKeyValues:dataDic];
//                [array addObject:baseModel];
//            }
//            
//            //设置数据模型
//            self.dataSourceArray = array;
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
        UIView * view  = [self.view viewWithTag:1000];
        if(view)
        {
            [view removeFromSuperview];
        }
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:[jsonDic valueForKey:@"message"]];
    }
}

@end
