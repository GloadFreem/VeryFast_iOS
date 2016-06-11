//
//  CircleViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/3.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "CircleViewController.h"
#import "CircleListModel.h"
#import "CircleListCell.h"
#import "CircleReleaseVC.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

#import "CircleBaseModel.h"
#import "CircleDetailVC.h"

#define CIRCLE_CONTENT @"requestFeelingList"

@interface CircleViewController ()<UITableViewDelegate,UITableViewDataSource,CircleListCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;  //数据数组
@property (nonatomic, assign) NSInteger page;

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    //获得partner
    self.partner = [TDUtil encryKeyWithMD5:KEY action:CIRCLE_CONTENT];
    _page = 0;
    [self setupNav];
    [self createTableView];
    
    //下载数据
    [self loadData];
}


#pragma mark -设置导航栏
-(void)setupNav
{
    
    UIButton * releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [releaseBtn setBackgroundImage:[UIImage imageNamed:@"icon_circle_add"] forState:UIControlStateNormal];
    releaseBtn.size = releaseBtn.currentBackgroundImage.size;
    [releaseBtn addTarget:self action:@selector(releaseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:releaseBtn] ;
    self.navigationItem.title = @"圈子";
}
#pragma mark -创建tableView
-(void)createTableView
{
    _tableView  = [UITableView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //设置刷新控件
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHttp)];
    //自动改变透明度
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(nextPage)];

    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
}

-(void)nextPage
{
    _page ++;
    [self loadData];
//    NSLog(@"回到顶部");
}

-(void)refreshHttp
{
    _page = 0;
    
    [self loadData];
//    NSLog(@"下拉刷新");
}

-(void)loadData
{
    [SVProgressHUD show];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KEY,@"key",self.partner,@"partner",[NSString stringWithFormat:@"%ld",_page],@"page", nil];
    //开始请求
    [self.httpUtil getDataFromAPIWithOps:CYCLE_CONTENT_LIST postParam:dic type:0 delegate:self sel:@selector(requestCircleContentList:)];
}

-(void)requestCircleContentList:(ASIHTTPRequest *)request
{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
//    NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    
    if (_page == 0) {
        [_dataArray removeAllObjects];
    }
    
    if (jsonDic!=nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        if ([status intValue] == 200) {
            [SVProgressHUD dismiss];
            //解析数据  将data字典转换为BaseModel
            NSArray *dataArray = [NSArray arrayWithArray:jsonDic[@"data"]];
//            NSLog(@"shuzu------%@",dataArray[0]);
            for (NSInteger i =0; i < dataArray.count; i ++) {
                //实例化圈子模型
                CircleListModel *listModel = [CircleListModel new];
                
                //实例化返回数据baseModel
                CircleBaseModel *baseModel = [CircleBaseModel mj_objectWithKeyValues:dataArray[i]];
                //一级模型赋值
                listModel.timeSTr = baseModel.publicDate;  //发布时间
                listModel.iconNameStr = baseModel.users.headSculpture; //发布者头像
                listModel.nameStr = baseModel.users.name;   //发布者名字
                listModel.msgContent = baseModel.content;
                listModel.publicContentId = baseModel.publicContentId; //帖子ID
                //拿到usrs认证数组
                NSArray *authenticsArray = [NSArray arrayWithArray:baseModel.users.authentics];
                //实例化认证人模型
                CircleUsersAuthenticsModel *usersAuthenticsModel =authenticsArray[0];
                listModel.addressStr = usersAuthenticsModel.companyAddress;
                listModel.companyStr = usersAuthenticsModel.companyName;
                listModel.positionStr = usersAuthenticsModel.position;
                NSMutableArray *picArray = [NSMutableArray array];
                for (NSInteger i = 0; i < baseModel.contentimageses.count; i ++) {
                    CircleContentimagesesModel *imageModel = baseModel.contentimageses[i];
                    [picArray addObject:imageModel.url];
                }
                listModel.picNamesArray = [NSArray arrayWithArray:picArray];
//                NSLog(@"照片数组---%@",listModel.picNamesArray);
                //将model加入数据数组
                [_dataArray addObject:listModel];
                
            }
//            NSLog(@"数组个数---%ld",_dataArray.count);
            [_tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
        }else{
            
            [SVProgressHUD dismiss];
            [self.tableView.mj_header endRefreshing];
            [[DialogUtil sharedInstance]showDlg:self.view textOnly:[jsonDic valueForKey:@"message"]];
            
        }
        
    }
}

#pragma mark -tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataArray[indexPath.row];
    return [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[CircleListCell class] contentViewWidth:[self cellContentViewWith]];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CircleListCell";
    CircleListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[CircleListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    cell.indexPath = indexPath;
    __weak typeof (self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            CircleListModel *model =weakSelf.dataArray[indexPath.row];
            model.isOpening  = !model.isOpening;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
    }
    cell.delegate = self;
    

    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CircleListModel *listModel = _dataArray[indexPath.row];
    
    CircleDetailVC *detail = [CircleDetailVC new];
    detail.publicContentId  =listModel.publicContentId;//帖子ID
    detail.page = 0;
    [self.navigationController pushViewController:detail animated:YES];
    
}
#pragma mark -发布动态
-(void)releaseBtnClick:(UIButton*)btn
{
    CircleReleaseVC *vc = [CircleReleaseVC new];
    
    //隐藏tabbar
    AppDelegate * delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [delegate.tabBar tabBarHidden:YES animated:NO];
    
    [self.navigationController pushViewController:vc animated:YES];
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

#pragma mark- CircleListCellDelegate
-(void)didClickShareBtnInCell:(CircleListCell *)cell andModel:(CircleListModel *)model
{
    
}

-(void)didClickCommentBtnInCell:(CircleListCell *)cell andModel:(CircleListModel *)model
{
    
}

-(void)didClickPraiseBtnInCell:(CircleListCell *)cell andModel:(CircleListModel *)model
{
    if (model.isLiked) {
        [cell.praiseBtn setImage:[UIImage imageNamed:@"iconfont-dianzan"] forState:UIControlStateNormal];

    }else{
        [cell.praiseBtn setImage:[UIImage imageNamed:@"icon_dianzan"] forState:UIControlStateNormal];
    }
    model.liked = !model.liked;
    
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



@end
