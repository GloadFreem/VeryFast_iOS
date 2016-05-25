//
//  MineDataVC.m
//  JinZhiT
//
//  Created by Eugene on 16/5/25.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "MineDataVC.h"
#import "MyDataIconCell.h"
#import "MyDataArrowCell.h"
#import "MyDataHeaderCell.h"
#import "MyDataNoArrowCell.h"
#import "MineRingCodeVC.h"
#import "PlatformIdentityVC.h"
#import "MyDataCompanyVC.h"
@interface MineDataVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *textArray;    //
@property (nonatomic, strong) NSMutableArray *dataArray;    //
@property (nonatomic, strong) UIButton *bottomBtn;    // 底部btn
@property (nonatomic, strong) UILabel *bottomLabel;    //底部label


@end

@implementation MineDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _textArray = [NSArray array];
    _textArray = @[@"头像",@"指环码",@"实名认证信息(未认证)",@"姓名",@"平台身份",@"身份证号码",@"",@"公司",@"职位",@"所在地"];
    [self setupNav];
    
    [self createTableView];
    
    [self createBottomView];
}

#pragma mark- 创建tableView
-(void)createTableView
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView  = [UITableView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor redColor];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(450*HEIGHTCONFIG);
    }];
    
}

#pragma mark -设置导航栏
-(void)setupNav
{
    UIButton * leftback = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftback setBackgroundImage:[UIImage imageNamed:@"leftBack"] forState:UIControlStateNormal];
    leftback.size = leftback.currentBackgroundImage.size;
    [leftback addTarget:self action:@selector(leftBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftback] ;
    self.navigationItem.title = @"我的资料";
}
#pragma mark -初始化底部视图
-(void)createBottomView
{
    //上边label
    _bottomLabel = [UILabel new];
    [_bottomLabel setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
//    _bottomLabel.numberOfLines = 0;
    _bottomLabel.font = BGFont(12);
    _bottomLabel.textColor = color(74, 74, 74, 1);
    [self.view addSubview:_bottomLabel];
    
//    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_tableView.mas_bottom).offset(10*HEIGHTCONFIG);
//        make.left.mas_equalTo(self.view.mas_left).offset(10*WIDTHCONFIG);
//        make.right.mas_equalTo(self.view.mas_right).offset(-10*WIDTHCONFIG);
//        
//    }];
    _bottomLabel.sd_layout
    .leftSpaceToView(self.view,10*WIDTHCONFIG)
    .rightSpaceToView(self.view,10*WIDTHCONFIG)
    .topSpaceToView(_tableView,10*HEIGHTCONFIG)
    .autoHeightRatio(0);
    
    
    //底部button
    _bottomBtn = [UIButton new];
    _bottomBtn.backgroundColor = [UIColor orangeColor];
    [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _bottomBtn.titleLabel.font = BGFont(17);
    [self.view addSubview:_bottomBtn];
    
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-16*HEIGHTCONFIG);
        make.height.mas_equalTo(35*HEIGHTCONFIG);
        make.width.mas_equalTo(288*WIDTHCONFIG);
    }];
}
#pragma mark- 返回按钮
-(void)leftBack:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 85*HEIGHTCONFIG;
    }

    if (indexPath.row == 6) {
        return 8*HEIGHTCONFIG;
    }
    if (indexPath.row == 2) {
        return 31*HEIGHTCONFIG;
    }
    return 37*HEIGHTCONFIG;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString * cellId = @"MyDataIconCell";
        MyDataIconCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
        }
        cell.titleLabel.text = _textArray[indexPath.row];
        return cell;
    }
    if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 7 || indexPath.row == 9) {
        static NSString *cellId = @"MyDataArrowCell";
        MyDataArrowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
        }
        if (indexPath.row == 1 || indexPath.row == 9) {
            cell.bottomLine.hidden = YES;
        }
        cell.leftLabel.text = _textArray[indexPath.row];
        return cell;
    }
    if (indexPath.row == 2 || indexPath.row == 6) {
        static NSString *cellId =@"MyDataHeaderCell";
        MyDataHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
        }
        cell.titleLabel.text = _textArray[indexPath.row];
        if (indexPath.row == 6) {
            cell.titleLabel.hidden = YES;
        }
        return cell;
    }
    
    static NSString *cellId = @"MyDataNoArrowCell";
    MyDataNoArrowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
    }
    if (indexPath.row == 5) {
        cell.bottomLine.hidden = YES;
    }
    cell.leftLabel.text = _textArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        MineRingCodeVC *vc = [MineRingCodeVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 4) {
        PlatformIdentityVC *vc = [PlatformIdentityVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 7) {
        MyDataCompanyVC *vc = [MyDataCompanyVC new];
        [self.navigationController  pushViewController:vc animated:YES];
    }
    
}
@end
