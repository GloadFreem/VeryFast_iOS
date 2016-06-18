//
//  ProjectPrepareDetailVC.m
//  company
//
//  Created by Eugene on 16/6/17.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectPrepareDetailVC.h"

#import "ProjectPrepareHeaderCell.h"

#import "ProjectPreparePhotoCell.h"
#import "ProjectDetailLeftTeamCell.h"
#import "ProjectDetailLeftFooterCell.h"

#import "ProjectDetailBaseMOdel.h"
#import "ProjectPrepareDetailHeaderModel.h"
#import "ProjectDetailLeftHeaderModel.h"
#import "ProjectDetailLeftFooterModel.h"

#define PROJECTDETAIL @"requestProjectDetail"
@interface ProjectPrepareDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ProjectPrepareDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    //获得partner
    self.partner = [TDUtil encryKeyWithMD5:KEY action:PROJECTDETAIL];
    
    [self startLoadData];
    
    [self setupNav];
    
    [self createTableView];
    
    [self createBottomView];
    NSLog(@"projectId----%ld",self.projectId);
}
-(void)startLoadData
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KEY,@"key",self.partner,@"partner",[NSString stringWithFormat:@"%ld",_projectId],@"projectId", nil];
    //开始请求
    [self.httpUtil getDataFromAPIWithOps:REQUEST_PROJECT_DETAIL postParam:dic type:0 delegate:self sel:@selector(requestProjectDetail:)];
}

-(void)requestProjectDetail:(ASIHTTPRequest *)request
{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
    NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    
    if (jsonDic != nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        if ([status integerValue] == 200) {
            ProjectDetailBaseMOdel *baseModel = [ProjectDetailBaseMOdel mj_objectWithKeyValues:jsonDic[@"data"]];
            
            ProjectPrepareDetailHeaderModel *detailHeaderModel = [ProjectPrepareDetailHeaderModel new];
            detailHeaderModel.startPageImage = baseModel.project.startPageImage;
            detailHeaderModel.abbrevName = baseModel.project.abbrevName;
            detailHeaderModel.fullName = baseModel.project.fullName;
            detailHeaderModel.address = baseModel.project.address;
            
            [_dataArray addObject:detailHeaderModel];
            
            ProjectDetailLeftHeaderModel *leftHeaderModel = [ProjectDetailLeftHeaderModel new];
            leftHeaderModel.projectStr = baseModel.project.abbrevName;
            leftHeaderModel.content = baseModel.project.desc;
            leftHeaderModel.pictureArray = baseModel.project.projectimageses;
            
            [_dataArray addObject:leftHeaderModel];
            
            //数组为空   重新解析数据
            NSArray *teamsArray = [NSArray arrayWithArray:baseModel.project.teams];
//            NSLog(@"打印模型数组---%@",baseModel.project.teams);
//            NSLog(@"数组个数---%ld",teamsArray.count);
            [_dataArray addObject:teamsArray];
            
            NSArray *extrArray = [NSArray arrayWithArray:baseModel.extr];
//            NSLog(@"第二个数组个数---%ld",extrArray.count);
            [_dataArray addObject:extrArray];
            
//            NSLog(@"打印最大数组---------%@",_dataArray);
            [_tableView reloadData];
            
        }else{
            [[DialogUtil sharedInstance]showDlg:self.view textOnly:[jsonDic valueForKey:@"message"]];
        }
    }
}
-(void)setupNav
{
    UIView *navView = [UIView new];
    [navView setBackgroundColor:color(61, 153, 130, 1)];
    [self.view addSubview:navView];
    
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    
    UIButton *leftBtn = [UIButton new];
    [leftBtn setImage:[UIImage imageNamed:@"leftBack"] forState:UIControlStateNormal];
    [leftBtn setTag:0];
    [leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(37);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *shareBtn = [UIButton new];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"write-拷贝-2"] forState:UIControlStateNormal];
    [shareBtn setTag:1];
    [shareBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.size = shareBtn.currentBackgroundImage.size;
    [navView addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(leftBtn.mas_centerY);
        make.right.mas_equalTo(-22);
    }];
    
}
-(void)createTableView
{
    _tableView = [UITableView new];
    _tableView.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64-50);
    _tableView.backgroundColor = colorGray;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
//    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.top.mas_equalTo(64);
//        make.bottom.mas_equalTo(50);
//    }];
}

-(void)createBottomView
{
    UIView *bottomView = [UIView new];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *kefuBtn = [UIButton new];
    [kefuBtn setBackgroundImage:[UIImage imageNamed:@"icon_kefu"] forState:UIControlStateNormal];
    [kefuBtn setTag:2];
    [kefuBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    kefuBtn.size = kefuBtn.currentBackgroundImage.size;
    [bottomView addSubview:kefuBtn];
    [kefuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(3);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
    }];
    
    UIButton *investBtn = [UIButton new];
    [investBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-rocket"] forState:UIControlStateNormal];
    [investBtn setTag:3];
    investBtn.size = investBtn.currentBackgroundImage.size;
    [investBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:investBtn];
    [investBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-3);
    }];
    
}

#pragma mark ------------tableViewDatasource------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    return 0;
}

#pragma mark ------在线交流段头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, SCREENWIDTH, 50);
    
    UIImageView *image = [UIImageView new];
    image.image = [UIImage imageNamed:@"comments"];
    image.size = image.image.size;
    [view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(16);
    }];
    
    UILabel *textLabel = [UILabel new];
    textLabel.text = @"在线交流";
    textLabel.textColor = [UIColor blackColor];
    textLabel.font = BGFont(18);
    textLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.height.mas_equalTo(18);
        make.left.mas_equalTo(image.mas_right).offset(8);
    }];
    
    UILabel *numLabel = [UILabel new];
    numLabel.textAlignment  = NSTextAlignmentLeft;
    numLabel.textColor = color47;
    numLabel.font = BGFont(14);
    //设置文字信息
    
    [view addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(textLabel.mas_bottom);
        make.left.mas_equalTo(textLabel.mas_right);
        make.height.mas_equalTo(14);
    }];
    
    UIImageView *moreImage = [UIImageView new];
    moreImage.image = [UIImage imageNamed:@"youjinatou"];
    moreImage.size = moreImage.image.size;
    [view addSubview:moreImage];
    [moreImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.right.mas_equalTo(view.mas_right).offset(-8);
    }];
    
    UIButton *moreBtn =[UIButton new];
    [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [moreBtn setTitleColor:orangeColor forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.titleLabel.font = BGFont(14);
    [view addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(64);
        make.centerY.mas_equalTo(view.mas_centerY);
        make.right.mas_equalTo(moreImage.mas_left).offset(-5);
    }];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 50;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count) {
        if (indexPath.section == 0) {
            
            
            
            if (indexPath.row == 0) {
                return 200;
            }
            if (indexPath.row == 1) {
                ProjectDetailLeftHeaderModel *model = _dataArray[indexPath.row];
                return [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProjectPreparePhotoCell class] contentViewWidth:[self cellContentViewWith]];
            }
            if (indexPath.row == 2) {
                if ([_dataArray[indexPath.row] count]) {
                    return 187;
                }
                return 0.0000001f;
//                DetailTeams *model = _dataArray[indexPath.row][0];
//                return  [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProjectDetailLeftTeamCell class] contentViewWidth:[self cellContentViewWith]];
            }
            if (indexPath.row == 3) {
                if ([_dataArray[indexPath.row] count]) {
                    return 138;
                }
                return 0.0000001f;
//                DetailExtr *model = _dataArray[indexPath.row][0];
//                return [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProjectDetailLeftFooterCell class] contentViewWidth:[self cellContentViewWith]];
            }
        }

    }
        return 175;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *cellId = @"ProjectPrepareHeaderCell";
            ProjectPrepareHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:cellId owner:nil options:nil] lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_dataArray.count) {
               cell.model = _dataArray[indexPath.row];
            }
            
            return cell;
        }
        if (indexPath.row == 1) {
            static NSString *cellId = @"ProjectPreparePhotoCell";
            ProjectPreparePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[ProjectPreparePhotoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.indexPath = indexPath;
            __weak typeof (self) weakSelf = self;
            if (!cell.moreButtonClickedBlock) {
                [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
                    ProjectDetailLeftHeaderModel *model =weakSelf.dataArray[indexPath.row];
                    model.isOpen = !model.isOpen;
                    [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
            }
            if (_dataArray.count) {
                cell.model = _dataArray[indexPath.row];
            }
            return cell;
        }
        if (indexPath.row == 2) {
            static NSString *cellId = @"ProjectDetailLeftTeamCell";
            ProjectDetailLeftTeamCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[ProjectDetailLeftTeamCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_dataArray.count) {
                cell.modelArray = _dataArray[indexPath.row];
            }
            
            return cell;
        }
        if (indexPath.row == 3) {
            static NSString *cellId = @"ProjectDetailLeftFooterCell";
            ProjectDetailLeftFooterCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[ProjectDetailLeftFooterCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_dataArray.count) {
                cell.modelArray = _dataArray[indexPath.row];
            }
            
            return cell;
        }
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark ---导航栏按钮点击事件
-(void)btnClick:(UIButton*)btn
{
    if (btn.tag == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (btn.tag == 1) {
        NSLog(@"分享");
    }
    if (btn.tag == 2) {
        NSLog(@"联系客服");
    }
    if (btn.tag == 3) {
        NSLog(@"进入认投界面");
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
#pragma mark -moreBtn点击事件 处理
-(void)moreBtnClick:(UIButton*)btn
{
    NSLog(@"进入回复详情页");
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    AppDelegate * delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [delegate.tabBar tabBarHidden:NO animated:NO];
}
@end
