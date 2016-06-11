//
//  CircleDetailVC.m
//  JinZhiT
//
//  Created by Eugene on 16/5/27.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "CircleDetailVC.h"
#import "CircleDetailHeaderView.h"
#import "CircleDetailCommentCell.h"
#define CIRCLEDETAIL @"requestFeelingDetail"

@interface CircleDetailVC ()<UITableViewDelegate,UITableViewDataSource,CircleDetailHeaderViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITextField *textField;



@end

@implementation CircleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //获得partner
    self.partner = [TDUtil encryKeyWithMD5:KEY action:CIRCLEDETAIL];
    
    //设置导航栏
    [self setupNav];
    
    [self createTableView];
    
    [self loadData];
    
}

-(void)loadData
{
    NSLog(@"id====%ld",self.publicContentId);
    [SVProgressHUD show];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KEY,@"key",self.partner,@"partner",[NSString stringWithFormat:@"%ld",self.publicContentId],@"feelingId",[NSString stringWithFormat:@"%ld",_page],@"page",nil];
    //开始请求
    [self.httpUtil getDataFromAPIWithOps:CIRCLE_FEELING_DETAIL postParam:dic type:0 delegate:self sel:@selector(requestCircleDetail:)];
}

#pragma mark -网络请求
-(void)requestCircleDetail:(ASIHTTPRequest *)request
{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
//        NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    
    if (_page == 0) {
        [_dataArray removeAllObjects];
    }
    
    if (jsonDic!=nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        if ([status intValue] == 200) {
            [SVProgressHUD dismiss];
            //解析数据  将data字典转换为BaseModel
            NSLog(@"data字典---%@",jsonDic[@"data"]);
            
    
            [_tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
        }else{
            
            [SVProgressHUD dismiss];
            [self.tableView.mj_header endRefreshing];
            [[DialogUtil sharedInstance]showDlg:self.view textOnly:[jsonDic valueForKey:@"message"]];
            
        }
        
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏tabbar
    AppDelegate * delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [delegate.tabBar tabBarHidden:YES animated:NO];
    
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:NO];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //隐藏tabbar
    AppDelegate * delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [delegate.tabBar tabBarHidden:NO animated:NO];
    
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];
}
#pragma mark -设置导航栏
-(void)setupNav
{
    UIButton * leftback = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftback setBackgroundImage:[UIImage imageNamed:@"leftBack"] forState:UIControlStateNormal];
    leftback.tag = 0;
    leftback.size = leftback.currentBackgroundImage.size;
    [leftback addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftback] ;
    
    
    self.navigationItem.title = @"详情";
}

-(void)createTableView
{
    _tableView  = [UITableView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    CircleDetailHeaderView *headerView = [CircleDetailHeaderView new];
    
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50*HEIGHTCONFIG);
    }];
    // 回复框
    UIView *view = [UIView new];
    [view setFrame:CGRectMake(0, SCREENHEIGHT - 50*HEIGHTCONFIG - 64, SCREENWIDTH, 50 * HEIGHTCONFIG)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_tableView.mas_bottom);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = colorGray;
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(view);
        make.height.mas_equalTo(0.5);
    }];
    //输入框
    UITextField *field = [UITextField new];
    field.placeholder = @"请输入评论内容";
    field.layer.cornerRadius = 3;
    field.layer.borderColor = colorGray.CGColor;
    field.layer.borderWidth = .5f;
    field.delegate = self;
    [field setValue:color74 forKeyPath:@"_placeholderLabel.textColor"];
    field.textAlignment = NSTextAlignmentLeft;
    field.textColor = [UIColor blackColor];
    field.font = BGFont(14);
    field.returnKeyType = UIReturnKeyDone;
    _textField = field;
    CGRect frame = [field frame];
    frame.size.width = 15.0f;
    UIView *leftView = [[UIView alloc]initWithFrame:frame];
    field.leftView = leftView;
    field.leftViewMode = UITextFieldViewModeAlways;
    [view addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(10);
        make.right.mas_equalTo(view.mas_right).offset(-60);
        make.centerY.mas_equalTo(view.mas_centerY);
        make.height.mas_equalTo(36);
    }];
    
    UIButton *answerBtn = [UIButton new];
    [answerBtn setTitle:@"回复" forState:UIControlStateNormal];
    [answerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [answerBtn setBackgroundColor:colorBlue];
    answerBtn.titleLabel.font = BGFont(16);
    [answerBtn addTarget:self action:@selector(sendComment:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:answerBtn];
    [answerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(field.mas_right).offset(5);
        make.height.mas_equalTo(field.mas_height);
        make.centerY.mas_equalTo(field.mas_centerY);
        make.right.mas_equalTo(view.mas_right).offset(10);
    }];
}
#pragma mark -导航栏按钮点击事件
-(void)btnClick:(UIButton*)btn
{
    if (btn.tag == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -tableViewDatasource

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
    
    id model = self.dataArray[indexPath.row];
    return [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CircleDetailCommentCell class] contentViewWidth:[self cellContentViewWith]];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CircleDetailCommentCell";
    CircleDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[CircleDetailCommentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//评论帖子
-(void)sendComment:(UIButton*)btn
{
    if ([_textField.text isEqualToString:@""]) {
     UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"评论内容不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        
        [_textField resignFirstResponder];
        return;
    }
}

#pragma mark -cell_delegate
-(void)didClickPraiseBtn:(CircleDetailHeaderView *)view model:(CircleListModel *)model
{
    if (model.isLiked) {
        [view.praiseBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-dianzan"] forState:UIControlStateNormal];
        
    }else{
        [view.praiseBtn setBackgroundImage:[UIImage imageNamed:@"icon_dianzan"] forState:UIControlStateNormal];
    }
    model.liked = !model.liked;
    
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
@end
