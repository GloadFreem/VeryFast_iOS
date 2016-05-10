//
//  RenzhengViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/6.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "RenzhengViewController.h"
#import "Renzheng2ViewController.h"
#import "AreaViewController.h"


#import "EditTableViewCell.h"
#import "IdentityTableViewCell.h"

@interface RenzhengViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *nextStup;
@property (nonatomic, strong) NSArray * leftLableArr;
@property (nonatomic, strong) NSMutableArray * textFieldArr;


@end

@implementation RenzhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.scrollEnabled = NO;
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self createData];
}
//创建数据
-(void)createData{
    _leftLableArr = [NSArray arrayWithObjects:@"身份证号码",@"真实姓名",@"公司名称",@"公司所在地",@"担任职位", nil];
    _textFieldArr  = [[NSMutableArray alloc]initWithObjects:@"请输入身份证号码",@"请输入真实姓名",@"请输入公司名称",@"请选择公司所在地",@"请输入职位", nil];
}

#pragma mark -- tableView  data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 180;
    }
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
#pragma mark- tableView  delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellID = @"cellID";
        IdentityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"IdentityTableViewCell" owner:nil options:nil] lastObject];
            
        }
        return cell;
    }else{
    
    static NSString * cellId = @"cellId";
    EditTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EditTableViewCell" owner:nil options:nil] lastObject];
        
    }
        
        if (indexPath.row == 3) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
     //设置左边label的值
    cell.leftLabel.text = _leftLableArr[indexPath.row];
        cell.inputTextField.placeholder = _textFieldArr[indexPath.row];
     //计算label的宽度
    CGFloat width =  [cell.leftLabel.text commonStringWidthForFont:16];
    cell.leftLabelWidth.constant = width + 16;
    return cell;
    }
}
#pragma mark - tableView点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 3) {
//        AreaViewController * area = [AreaViewController new];
//        [self.navigationController pushViewController:area animated:YES];
//    }
//    NSLog(@"点击了第%d个cell",indexPath.row);
}

- (IBAction)nextStupClick:(UIButton *)sender {
    Renzheng2ViewController * regist = [Renzheng2ViewController new];
    [self.navigationController pushViewController:regist animated:YES];
}


//让当前控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
