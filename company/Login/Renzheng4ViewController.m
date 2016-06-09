//
//  Renzheng4ViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/6.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "Renzheng4ViewController.h"
#import "RegistNameTableViewCell.h"
#import "JTabBarController.h"
#import "AppDelegate.h"
@interface Renzheng4ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat tableViewH;
@end

@implementation Renzheng4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}
#pragma mark -- 初始化数据
-(void)initData{
    _dataArray = [NSMutableArray arrayWithObjects:@"《私募投资基金监督管理暂行办法》规定的合格投资者",@"投资单个融资项目的最低金额不低于100万元人民币的单位或个人",@"社会保障基金、企业年金等养老基金，慈善基金等社会公益基金，以及依法设立并在中国证券投资基金业协会备案的投资计划",@"净资产不低于1000万元人民币的单位",@"金融资产不低于300万元人民币或最近三年个人年均收入不低于50万元人民币的个人。上述个人除能提供相关财产、收a入证明外，还应当能辨识、判断和承担相应投资风险",@"证券业协会规定的其他投资者", nil];
}

#pragma mark- tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_height > 35) {
        
        return _height + 16;
    }
    
    return 44;
    
}
-(void)getTableViewHeight{
    _tableViewH += _height;
    if (_tableViewH > 300) {
        _tableViewHeight.constant = _tableViewH;
    }
}
#pragma mark- tableViewDelegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cellID";
    RegistNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RegistNameTableViewCell" owner:nil options:nil] lastObject];
        
    }
    cell.leftButton.tag = indexPath.row;
    cell.rightLabel.text = _dataArray[indexPath.row];
    cell.rightLabel.numberOfLines = 0;
    CGFloat height = [cell.rightLabel.text commonStringHeighforLabelWidth:239 withFontSize:16];
//    NSLog(@"高度是%f",height);
    cell.rightLabelHeight.constant = height;
    _height = height;
    if (indexPath.row == _dataArray.count-1) {
        [self getTableViewHeight];
    }
    return cell;
}
- (IBAction)backBtnClick:(UIButton *)sender {
}

- (IBAction)doneBtnClick:(UIButton *)sender {
    
    AppDelegate * app =(AppDelegate* )[[UIApplication sharedApplication] delegate];
    app.window.rootViewController = app.tabBar;
}


//让当前控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
