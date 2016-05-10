//
//  AreaViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/7.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "AreaViewController.h"
#import "RenzhengViewController.h"
#import "DetailAreaViewController.h"
@interface AreaViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation AreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArray =[NSMutableArray array];
    [self createData];
}

#pragma mark- 创建数据
-(void)createData{
    _dataArray =[ @[@"北京",@"上海",@"重庆",@"天津",@"陕西",@"山西",@"云南",@"广东"] mutableCopy];
}

#pragma mark- tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma mark- tableViewDelagate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //通过一个标识从缓存池寻找可循环利用的cell
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    //如果没有就创建一个
    if (cell==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark- tableViewCell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        DetailAreaViewController * detail =[DetailAreaViewController new];
        [self.navigationController pushViewController:detail animated:YES];
    }
   
}
- (IBAction)backBtnClick:(UIButton *)sender {
    RenzhengViewController  * ren = [RenzhengViewController new];
    [self.navigationController pushViewController:ren animated:YES];
}


@end
