//
//  InvistViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/7.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "InvistViewController.h"
#import "InvistTableViewCell.h"
#import "NSString+Addition.h"
@interface InvistViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation InvistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _dataArray = [NSMutableArray array];
    [self createData];
}
#pragma mark- 拿数据
-(void)createData{
    _dataArray = [@[@"互联网/电子",@"商贸/租赁",@"文体/艺术",@"运输/仓储",@"能源/环保",@"医疗/卫生",@"农业/牧业",@"金融业",@"服务业",@"制造业",@"其他"] mutableCopy];
}
#pragma mark - tableView DataSource 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark- tableView delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellId";
    InvistTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InvistTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.leftLabel.text = _dataArray[indexPath.row];
    CGFloat width = [cell.leftLabel.text commonStringWidthForFont:17];
    cell.leftLabelWidth.constant = width;
    return cell;
}
@end
