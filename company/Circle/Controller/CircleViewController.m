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
    
}

-(void)refreshHttp
{
    
}

-(void)loadData
{
    [SVProgressHUD show];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KEY,@"key",self.partner,@"partner",@"0",@"page", nil];
    //开始请求
    [self.httpUtil getDataFromAPIWithOps:CYCLE_CONTENT_LIST postParam:dic type:0 delegate:self sel:@selector(requestCircleContentList:)];
}

-(void)requestCircleContentList:(ASIHTTPRequest *)request
{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
//    NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    
    if (jsonDic!=nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        if ([status intValue] == 200) {
            [SVProgressHUD dismiss];
            //解析数据  将data字典转换为BaseModel
            NSArray *dataArray = [NSArray arrayWithArray:jsonDic[@"data"]];
            NSLog(@"data----%@",dataArray);
            NSDictionary *dataDic = [[NSDictionary alloc]initWithDictionary:dataArray[0]];
            
            NSLog(@"content_-------%@",dataDic);
            
            
        }else{
            
            [SVProgressHUD dismiss];
            [[DialogUtil sharedInstance]showDlg:self.view textOnly:[jsonDic valueForKey:@"message"]];
            
        }
        
    }
}
-(NSArray*)createModelWithCount:(NSInteger)count
{
    CircleListModel *model = [CircleListModel new];
    model.picNamesArray = @[@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png"];
    model.iconNameStr = @"logo_icon";
    model.nameStr = @"张丹三";
    model.addressStr = @"北京";
    model.companyStr = @"北京金指投";
    model.positionStr = @"总经理";
    model.msgContent = @"iPhone 6采用4.7英寸屏幕，分辨率为1334*750像素，内置64位构架的苹果A8处理器，性能提升非常明显；同时还搭配全新的M8协处理器，专为健康应用所设计；采用后置800万像素镜头，前置120万像素 鞠昀摄影FaceTime HD 高清摄像头；并且加入Touch ID支持指纹识别，首次新增NFC功能";
    model.timeSTr = @"2016-5-26";
    
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSInteger i=0; i< count; i++) {
        [mArr addObject:model];
    }
    return [mArr copy];
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
    
}
#pragma mark -发布动态
-(void)releaseBtnClick:(UIButton*)btn
{
    CircleReleaseVC *vc = [CircleReleaseVC new];
    
    //隐藏tabbar
    AppDelegate * delegate =[UIApplication sharedApplication].delegate;
    
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
