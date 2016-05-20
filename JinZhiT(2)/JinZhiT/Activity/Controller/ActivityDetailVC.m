//
//  ActivityDetailVC.m
//  JinZhiT
//
//  Created by Eugene on 16/5/19.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ActivityDetailVC.h"
#import "ActivityCell.h"
#import "ActivityDetailHeaderCell.h"
#import "ActivityDetailHeaderModel.h"
#import "ActivityDetailExiciseContentCell.h"
#import "ActivityDetailExerciseCell.h"
#import "ActivityDetailListCell.h"
#define kActivityDetailHeaderCellId @"ActivityDetailHeaderCell"

@interface ActivityDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;   //所有数据
@property (nonatomic, strong) UIButton *signUpBtn;          //报名按钮
@property (nonatomic, strong) UIButton *shareBtn;           //分享按钮

@end

@implementation ActivityDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets  = NO;
    
    [self setUpNavBar];
    _dataSource = [NSMutableArray array];
    [_dataSource addObjectsFromArray:[self createModels]];
    //初始化 控件
    [self createUI];
    
}
-(void)setUpNavBar
{
    [self.navigationItem setTitle:@"活动详情"];
    UIButton * leftback = [UIButton buttonWithType:UIButtonTypeCustom];
    leftback.tag = 0;
    [leftback setBackgroundImage:[UIImage imageNamed:@"leftBack"] forState:UIControlStateNormal];
    leftback.size = leftback.currentBackgroundImage.size;
    [leftback addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftback];
}

#pragma mark -初始化控件
-(void)createUI
{
    _tableView = [[UITableView alloc]init];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
    }];
    //报名按钮
    _signUpBtn = [[UIButton alloc]init];
    _signUpBtn.backgroundColor = [UIColor orangeColor];
    [_signUpBtn setTitle:@"我要报名" forState:UIControlStateNormal];
    [_signUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_signUpBtn.titleLabel setFont:BGFont(19)];
    [self.view addSubview:_signUpBtn];
    //分享按钮
    _shareBtn = [[UIButton alloc]init];
    _shareBtn.backgroundColor = color(67, 179, 204, 1);
    [_shareBtn setTitle:@"我要分享" forState:UIControlStateNormal];
    [_shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_shareBtn.titleLabel setFont:BGFont(19)];
    [self.view addSubview:_shareBtn];
    CGFloat width = SCREENWIDTH/2;
    CGFloat height = 50;
    [_signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(width);
    }];
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(width);
    }];
}

-(NSArray*)createModels
{
    ActivityDetailHeaderModel *model =[ActivityDetailHeaderModel new];
    model.title = @"投资人前期应该准给什么东西\n金指投指导中心";
    model.content = @"iPhone 6采用4.7英寸屏幕，分辨率为1334*750像素，内置64位构架的苹果A8处理器，性能提升非常明显；同时还搭配全新的M8协处理器，专为健康应用所设计；采用后置800万像素镜头，前置120万像素 鞠昀摄影FaceTime HD 高清摄像头；并且加入Touch ID支持指纹识别，首次新增NFC功能";
    model.pictureArray = @[@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png"];
    NSMutableArray *mArr = [NSMutableArray array];
    [mArr addObject:model];
    return mArr;
}
#pragma mark -tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        id model =self.dataSource[0];
        return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ActivityDetailHeaderCell class] contentViewWidth:[self cellContentViewWith]];
    }else if(indexPath.row == 1)
    {
        return 140;
    }else if(indexPath.row == 2)
    {
        return 48;
    }
    return 67;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row  == 0) {
        static NSString *cellId =@"ActivityDetailHeaderCell";
        ActivityDetailHeaderCell *cell =[tableView dequeueReusableCellWithIdentifier:kActivityDetailHeaderCellId];
        if (!cell) {
            cell = [[ActivityDetailHeaderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        cell.indexPath = indexPath;
        __weak typeof (self) weakSelf = self;
        if (!cell.moreButtonClickedBlock) {
            [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
                ActivityDetailHeaderModel *model =weakSelf.dataSource[0];
                model.isOpen = !model.isOpen;
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
        cell.model = self.dataSource[0];
        return cell;
    }else if (indexPath.row == 1){
        static NSString *cellId = @"ActivityDetailExiciseContentCell";
        ActivityDetailExiciseContentCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:cellId owner:nil options:nil] lastObject];
        }
        return cell;
    }else if (indexPath.row == 2){
        static NSString *cellId = @"ActivityDetailExerciseCell";
        ActivityDetailExerciseCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
        }
        return cell;
    }else if(indexPath.row < 8)
    {
        static NSString *cellId = @"ActivityDetailListCell";
        ActivityDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
        }
        return cell;
    }
    
    return nil;
}

#pragma mark -btnAction
-(void)btnClick:(UIButton*)btn
{
    if (btn.tag == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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

-(void)viewWillAppear:(BOOL)animated
{
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    AppDelegate * delegate =[UIApplication sharedApplication].delegate;
    
    [delegate.tabBar tabBarHidden:NO animated:NO];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
