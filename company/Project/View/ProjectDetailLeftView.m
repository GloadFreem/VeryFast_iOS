//
//  ProjectDetailLeftView.m
//  JinZhiT
//
//  Created by Eugene on 16/5/14.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailLeftView.h"
#import "ProjectDetailLeftHeaderCell.h"
#import "ProjectDetailLeftTeamCell.h"
#import "ProjectDetailLeftFooterCell.h"
#import "ProjectDetailLeftHeaderModel.h"
#import "ProjectDetailLeftTeamModel.h"
#import "ProjectDetailLeftFooterModel.h"

@implementation ProjectDetailLeftView
{
    UITableView *_tableView;
    UIView *_bottomView;  //最底层色块
    UIButton *_serviceBtn; //客服
    UIButton *_investBtn;   //跟投按钮
    NSMutableArray *_dataArray;
    CGFloat _cellHeight;
    
    CGFloat _tableHeight;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = colorGray;
        
        _dataArray = [NSMutableArray array];
        _cellHeight = 0;
        [self createUI];
    }
    return self;
}


#pragma mark -创建内部视图
-(void)createUI
{
    ProjectDetailLeftHeaderModel *model = [ProjectDetailLeftHeaderModel new];
    model.projectStr = @"逸景营地";
    model.goalStr = @"1000万";
    model.achieveStr = @"800万";
    model.timeStr = @"2016.6.1";
    model.addressStr = @"陕西 | 西安";
    model.statusStr = @"路演中";
    model.content = @"迪士尼代表动画角色，米老鼠的最初原型是他的设计伙伴伍培·艾沃克斯（iwerke)执笔设计的。维·史密斯和费洛伊德·戈特佛森创作的米老鼠的故事。米老鼠的形象设计出来以后，迪士尼开始用它来制作动画片。";
    model.pictureArray = @[@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png"];
    
    [_dataArray addObject:model];
    
    ProjectDetailLeftTeamModel * teamModel = [ProjectDetailLeftTeamModel new];
    [_dataArray addObject:teamModel];
    
    ProjectDetailLeftFooterModel * footerModel = [ProjectDetailLeftFooterModel new];
    [_dataArray addObject:footerModel];
    
    
    _tableView = [[UITableView alloc]init];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:_tableView];
    _tableView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self);
    
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bottomView];
    _bottomView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(_tableView,0)
    .heightIs(50);
    
    _serviceBtn = [UIButton new];
    [_serviceBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-kefu"] forState:UIControlStateNormal];
    [_serviceBtn setTag:300];
    [_serviceBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _serviceBtn.layer.cornerRadius = 20;
    _serviceBtn.layer.masksToBounds = YES;
    [_bottomView addSubview:_serviceBtn];
    _serviceBtn.sd_layout
    .leftSpaceToView(_bottomView,8*WIDTHCONFIG)
    .topSpaceToView(_bottomView,5)
    .bottomSpaceToView(_bottomView,5)
    .widthIs(100*WIDTHCONFIG);
    
    
    _investBtn = [UIButton new];
    [_investBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-rocket"] forState:UIControlStateNormal];
    [_investBtn setTag:301];
    [_investBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _investBtn.layer.cornerRadius = 20;
    _investBtn.layer.masksToBounds = YES;
    [_bottomView addSubview:_investBtn];
    _investBtn.sd_layout
    .leftSpaceToView(_serviceBtn,24*WIDTHCONFIG)
    .heightRatioToView(_serviceBtn,1)
    .centerYEqualToView(_serviceBtn)
    .rightSpaceToView(_bottomView,8*WIDTHCONFIG);
    
    [self setupAutoHeightWithBottomView:_tableView bottomMargin:0];
}

#pragma mark -tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count-1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = _dataArray[indexPath.row];
    
    switch (indexPath.row) {
        case 0:
            _cellHeight = [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProjectDetailLeftHeaderCell class] contentViewWidth:[self cellContentViewWith]];
            _tableHeight = _cellHeight;
            break;
        case 1:
            _cellHeight = [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProjectDetailLeftTeamCell class] contentViewWidth:[self cellContentViewWith]];
            _tableHeight +=_cellHeight;
            _tableView.height = _tableHeight;
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"calcauteHieght" object:nil userInfo:[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%f",_tableHeight],@"height", nil]];
            
            break;
        case 2:
            _cellHeight = [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProjectDetailLeftFooterCell class] contentViewWidth:[self cellContentViewWith]];
            
            _tableHeight +=_cellHeight;
            _tableView.height = _tableHeight;
            
            
            
            
            [self setupAutoHeightWithBottomView:_tableView bottomMargin:0];
            
            break;
        default:
            
            
            _cellHeight = [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProjectDetailLeftHeaderCell class] contentViewWidth:[self cellContentViewWith]];
            _tableHeight = _cellHeight;
            break;
    }
    
    
    
    return _cellHeight;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *cellId = @"ProjectDetailLeftHeaderCell";
        ProjectDetailLeftHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[ProjectDetailLeftHeaderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        cell.indexPath = indexPath;
        //        __weak typeof (self) weakSelf = self;
        if (!cell.moreButtonClickedBlock) {
            [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
                ProjectDetailLeftHeaderModel *model =_dataArray[0];
                model.isOpen = !model.isOpen;
//                [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [_tableView reloadData];
            }];
        }
        cell.model = _dataArray[0];
        return cell;
    }
    if (indexPath.row == 1) {
        static NSString *cellId = @"ProjectDetailLeftTeamCell";
        ProjectDetailLeftTeamCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[ProjectDetailLeftTeamCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        cell.modelArray = @[_dataArray[1]];
        
        return cell;
    }
    
    static NSString *cellId = @"ProjectDetailLeftFooterCell";
    ProjectDetailLeftFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ProjectDetailLeftFooterCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.modelArray = @[_dataArray[2]];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
#pragma mark -  底部按钮点击事件
-(void)btnClick:(UIButton*)btn
{
    if (btn.tag == 300) {
        
    }
    if (btn.tag == 301) {
        
    }
}
#pragma mark - 计算高度
-(CGFloat)calculateHeight
{
    return _tableHeight;
}

@end
