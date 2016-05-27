//
//  AppSetVC.m
//  JinZhiT
//
//  Created by Eugene on 16/5/25.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "AppSetVC.h"
#import "AppSetSwitchCell.h"
#import "AppSetHeaderCell.h"
#import "AppSetModifyPasswordVC.h"
#import "AppSetChangePhoneVC.h"
@interface AppSetVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation AppSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArray = [NSArray array];
    _dataArray  = @[@"安全设置",@"修改登录密码",@"更换绑定手机",@"管理通知",@"声音提醒",@"震动提醒",@"",@"清理缓存",@"版本更新"];
    
    [self setupNav];
    
    [self createTableView];
    
    
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
//    _tableView.backgroundColor = [UIColor redColor];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(380);
    }];
    
    UIButton *leaveBtn = [UIButton new];
    [leaveBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [leaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leaveBtn.titleLabel.font = BGFont(17);
    [leaveBtn setBackgroundColor:orangeColor];
    leaveBtn.layer.cornerRadius = 3;
    leaveBtn.layer.masksToBounds = YES;
    [leaveBtn addTarget:self action:@selector(leaveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leaveBtn];
    
    [leaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tableView.mas_bottom).offset(50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(312*WIDTHCONFIG);
        make.height.mas_equalTo(39*HEIGHTCONFIG);
    }];
}
#pragma mark -退出登录
-(void)leaveBtnClick:(UIButton*)btn
{
    
}

#pragma mark -设置导航栏
-(void)setupNav
{
    UIButton * leftback = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftback setBackgroundImage:[UIImage imageNamed:@"leftBack"] forState:UIControlStateNormal];
    leftback.size = leftback.currentBackgroundImage.size;
    [leftback addTarget:self action:@selector(leftBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftback] ;
    self.navigationItem.title = @"软件设置";
}

#pragma mark- 返回按钮
-(void)leftBack:(UIButton*)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        return 28;
    }
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 6) {
        static NSString *cellId = @"AppSetHeaderCell";
        AppSetHeaderCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = _dataArray[indexPath.row];
        return cell;
    }
    if (indexPath.row == 4 || indexPath.row == 5) {
        static NSString *cellId = @"AppSetSwitchCell";
        AppSetSwitchCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:nil options:nil] lastObject];
        }
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titlelabel.text = _dataArray[indexPath.row];
        
        return cell;
    }
    static NSString * cellId = @"UITableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    if (indexPath.row == 1 || indexPath.row == 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 1 || indexPath.row == 7) {
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView.mas_left).offset(17);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(cell.contentView.mas_bottom);
            make.right.mas_equalTo(cell.contentView.mas_right);
        }];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.font = BGFont(17);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        AppSetModifyPasswordVC *vc = [AppSetModifyPasswordVC new];
        [self.navigationController  pushViewController:vc animated:YES];
        
    }
    if (indexPath.row == 2) {
        AppSetChangePhoneVC *vc = [AppSetChangePhoneVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
