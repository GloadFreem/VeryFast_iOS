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
#import "ActivityDetailFooterView.h"

#import "ActivityDetailCommentCellModel.h"


#define kActivityDetailHeaderCellId @"ActivityDetailHeaderCell"
static CGFloat textFieldH = 40;

@interface ActivityDetailVC ()<UITableViewDelegate,UITableViewDataSource,ActivityDetailFooterViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;   //所有数据
@property (nonatomic, strong) UIButton *signUpBtn;          //报名按钮
@property (nonatomic, strong) UIButton *shareBtn;           //分享按钮
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL isReplayingComment;
@property (nonatomic, copy) NSString *commentToUser;

@end

@implementation ActivityDetailVC
{
    CGFloat _totalKeybordHeight;
    //底部点赞评论
    ActivityDetailFooterView *footerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets  = NO;
    
    [self setUpNavBar];
    _dataSource = [NSMutableArray array];
    [_dataSource addObjectsFromArray:[self createModels]];
    //初始化 控件
    [self createUI];
    
    [self setupTextField];
    
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
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.01f)];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
    }];
//    ActivityDetailFooterView *footerView = [ActivityDetailFooterView new];
//    footerView.frame = CGRectMake(0, 0, SCREENWIDTH, 180);
//    footerView.model = _dataSource[1];
//    footerView.backgroundColor = [UIColor redColor];
    
//    _tableView.tableFooterView = footerView;
    //报名按钮
    _signUpBtn = [[UIButton alloc]init];
    _signUpBtn.backgroundColor = orangeColor;
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

-(void)dealloc
{
    [_textField removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupTextField
{
    _textField = [UITextField new];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
    _textField.layer.borderWidth = 1;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width, textFieldH);
    [[UIApplication sharedApplication].keyWindow addSubview:_textField];
    
    [_textField becomeFirstResponder];
    [_textField resignFirstResponder];
}
-(NSArray*)createModels
{
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
                               @"正宗好凉茶，正宗好声音。。。",
                               @"你好，我好，大家好才是真的好",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
                               @"人艰不拆",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"我勒个去，啥世道啊",
                               @"真有意思啊你💢💢💢"];

    
    ActivityDetailHeaderModel *model =[ActivityDetailHeaderModel new];
    model.title = @"投资人前期应该准给什么东西\n金指投指导中心";
    model.content = @"iPhone 6采用4.7英寸屏幕，分辨率为1334*750像素，内置64位构架的苹果A8处理器，性能提升非常明显；同时还搭配全新的M8协处理器，专为健康应用所设计；采用后置800万像素镜头，前置120万像素 鞠昀摄影FaceTime HD 高清摄像头；并且加入Touch ID支持指纹识别，首次新增NFC功能";
    model.pictureArray = @[@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png",@"2010年11月25日-Blue-Footed-Booby,-Galápagos-Islands.png"];
    
    ActivityDetailCommentCellModel *commentCellModel = [ActivityDetailCommentCellModel new];
    //模拟随机平困数据
    int commentRandom = arc4random_uniform(3);
    //测试
    commentRandom = 10;
    
    NSMutableArray *tempComments = [NSMutableArray new];
    for (int i =0; i < commentRandom; i++) {
        ActivityDetailCellCommentItemModel *commentItemModel = [ActivityDetailCellCommentItemModel new];
        int index =arc4random_uniform((int)namesArray.count);
        commentItemModel.firstUserName = namesArray[index];
        commentItemModel.firstUserId = @"666";
        if (arc4random_uniform(10) < 5) {
            commentItemModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
            commentItemModel.secondUserId = @"888";
        }
        commentItemModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
        [tempComments addObject:commentItemModel];
    }
    commentCellModel.commentItemsArray = [NSArray array];
    commentCellModel.commentItemsArray  = [tempComments copy];
    
    //模拟随机点赞数据
    int likeRandom = arc4random_uniform(3);
    
    //测试
    likeRandom = 30;
    
    NSMutableArray *tempLikes = [NSMutableArray new];
    for (int i = 0; i < likeRandom; i++) {
        ActivityDetailCellLikeItemModel *model = [ActivityDetailCellLikeItemModel new];
        int index = arc4random_uniform((int)namesArray.count);
        model.userName = namesArray[index];
        model.userId = namesArray[index];
        [tempLikes addObject:model];
    }
    commentCellModel.likeItemsArray = [NSArray array];
    commentCellModel.likeItemsArray = [tempLikes copy];
    
    
    NSMutableArray *mArr = [NSMutableArray array];
    [mArr addObject:model];
    [mArr addObject:commentCellModel];
    return mArr;
}
#pragma mark -tableViewDataSource
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (!footerView) {
        __weak typeof(self) weakSelf = self;
        
        footerView = [ActivityDetailFooterView new];
        [footerView setDidClickCommentLabelBlock:^(NSString * commentId, CGRect rectInWindow) {
            weakSelf.textField.placeholder =[NSString stringWithFormat:@"  回复：%@",commentId];
            [weakSelf.textField becomeFirstResponder];
            weakSelf.isReplayingComment = YES;
            weakSelf.commentToUser = commentId;
            [weakSelf adjustTableViewToFitKeyboardWithRect];
        }];
        
        footerView.delegate = self;
        footerView.model = _dataSource[1];
        
        //容器
        UIView *view = [UIView new];
        [view addSubview:footerView];
        
        view.sd_layout.widthIs(self.view.frame.size.width).autoHeightRatio(0);
        
        footerView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        //主动刷新UI
        [footerView updateLayout];
    }
    
    return footerView;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
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
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    if (!footerView) {
        footerView = (ActivityDetailFooterView *)[self tableView:tableView viewForFooterInSection:section];
    }
    return footerView.height;
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
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:YES]
    ;
    AppDelegate * delegate =[UIApplication sharedApplication].delegate;
    
    [delegate.tabBar tabBarHidden:NO animated:NO];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)adjustTableViewToFitKeyboardWithRect
{
    
}
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [_textField resignFirstResponder];
        
    }
    return NO;
}
- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - textFieldH, rect.size.width, textFieldH);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _textField.frame = textFieldRect;
    }];
    
    CGFloat h = rect.size.height + textFieldH;
    if (_totalKeybordHeight != h) {
        _totalKeybordHeight = h;
        [self adjustTableViewToFitKeyboardWithRect];
    }
}


@end
