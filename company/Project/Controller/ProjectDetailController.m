//
//  ProjectDetailController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/9.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailController.h"
#import "AppDelegate.h"
#import "MeasureTool.h"

#import "ProjectDetailBannerView.h"

#import "ProjectDetailMemberView.h"

#import "ProjectDetailLeftView.h"
#import "ProjectDetailSceneView.h"


#import "ProjectDetailBaseMOdel.h"
#import "ProjectDetailMemberModel.h"


#define REQUESTDETAIL @"requestProjectDetail"


#define REQUESTRECORDATA @"requestRecorData"
#define REQUESTPROJECTCOMMENT @"requestProjectComment"

#define defaultLineColor [UIColor blueColor]
#define selectTitleColor orangeColor
#define unselectTitleColor [UIColor blackColor]
#define titleFont [UIFont systemFontOfSize:16]


@interface ProjectDetailController ()<ProjectDetailBannerViewDelegate,UIScrollViewDelegate>
{
    ProjectDetailMemberView * member;
    
    
    NSString *_recorDataPartner;
    BOOL memberLoadData;
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) UIScrollView *titleScrollView;     //切换按钮
@property (nonatomic,strong) NSArray *titleArray;               // 切换按钮数组
@property (nonatomic,strong) UIView *lineView;                  // 下划线视图
@property (nonatomic,strong) UIScrollView *subViewScrollView;   // 下边子滚动视图
@property (nonatomic,strong) NSMutableArray *heightArray;       // subviewScrollView子视图高度数组
@property (nonatomic,strong) NSMutableArray *btArray;           //点击切换按钮数组

@property (nonatomic, strong) UIView *bottomView;   //底部按钮视图
@property (nonatomic, strong) UIButton *kefuBtn;  //客服按钮
@property (nonatomic, strong) UIButton *investBtn;   //投资按钮


@end

@implementation ProjectDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //获得内容partner
    self.partner = [TDUtil encryKeyWithMD5:KEY action:REQUESTDETAIL];
    
    
    
    //下载详情数据
//    [self startLoadData];
    
    _heightArray = [NSMutableArray array];                  //子视图高度数组
    
    _scrollView.bounces = NO;                               //关闭弹性
    
    _scrollView.autoresizingMask = UIViewAutoresizingNone;
    
    //广告栏视图
    ProjectDetailBannerView * bannerView= [[ProjectDetailBannerView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH*0.6)];
    NSArray * array = [NSArray array];
    [bannerView relayoutWithModelArr:array];
    
    [_scrollView addSubview:bannerView];                     //添加广告栏
    
    _titleArray = @[@"详情",@"成员",@"现场"];
    _lineColor = orangeColor;
    _type = 0;
    [_scrollView addSubview:self.titleScrollView];          //添加点击按钮
    [_scrollView addSubview:self.subViewScrollView];        //添加最下边scrollview
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(calcuateLeftViewHeightNotification:) name:@"calcauteHieght" object:nil];
    
}

-(void)startLoadData
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KEY,@"key",self.partner,@"partner",[NSString stringWithFormat:@"%ld",self.projectId],@"projectId", nil];
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
            
            
        }else{
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:[jsonDic valueForKey:@"message"]];
        }
    }
}

#pragma mark - 设置下滑条
- (void)setLineColor:(UIColor *)lineColor{
    
    _lineColor = lineColor;
    [_lineView setBackgroundColor:self.lineColor ? _lineColor : defaultLineColor];
}

#pragma mark - 初始化切换按钮
- (UIScrollView *)titleScrollView{
    
    if (!_titleScrollView) {
        
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,SCREENWIDTH*0.6, SCREENWIDTH, 40)];
        _titleScrollView.contentSize = CGSizeMake(SCREENWIDTH*_titleArray.count/3, 0);
        _titleScrollView.scrollEnabled = YES;
        _titleScrollView.showsHorizontalScrollIndicator = YES;
    }
    
    for (int i = 0; i<_titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setFrame:CGRectMake(SCREENWIDTH/3*i, 0, SCREENWIDTH/3, 40)];
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:titleFont];
        button.tag = i+10;
        
        i==0 ? [button setTitleColor:selectTitleColor forState:UIControlStateNormal] : [button setTitleColor: unselectTitleColor forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_titleScrollView addSubview:button];
        [_btArray addObject:button];
    }
    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    [_lineView setBackgroundColor:self.lineColor ? _lineColor : defaultLineColor];
    
    if (self.type == 0) {
        
        _lineView.frame = CGRectMake(0, CGRectGetHeight(_titleScrollView.frame)-2, SCREENWIDTH/3, 2);
        [_titleScrollView addSubview:_lineView];
        
    }else{
        
        _lineView.frame = CGRectMake(0, 0, 80, CGRectGetMaxX(_titleScrollView.frame));
        [_titleScrollView insertSubview:_lineView atIndex:0];
    }
    
    
    return _titleScrollView;
}

#pragma mark -  初始化内部scrollView布局
- (UIScrollView *)subViewScrollView{
    
    if (!_subViewScrollView) {
        //        _subViewScrollView.backgroundColor = [UIColor greenColor];
        _subViewScrollView = [[UIScrollView alloc]init];
        
        _subViewScrollView.bounces = NO;
        _subViewScrollView.showsHorizontalScrollIndicator = NO;
        _subViewScrollView.showsVerticalScrollIndicator = NO;
        _subViewScrollView.contentSize = CGSizeMake(SCREENWIDTH*_titleArray.count, 0);
        _subViewScrollView.delegate = self;
        _subViewScrollView.alwaysBounceVertical = NO;
        _subViewScrollView.pagingEnabled = YES;
        //方向锁
        _subViewScrollView.directionalLockEnabled = YES;
        
        //实例化详情分页面
        
        //        ProjectDetailFirstHeaderView *detail = [ProjectDetailFirstHeaderView instancetypeProjectDetailFirstHeaderView];
        //        detail.frame = CGRectMake(0, 0, SCREENWIDTH, detail.viewHeight);
        //        [_heightArray addObject:[NSNumber numberWithFloat:detail.viewHeight]];
        //        _subViewScrollView.frame = CGRectMake(0, CGRectGetMaxY(_titleScrollView.frame), SCREENWIDTH, detail.viewHeight);
        //         _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_subViewScrollView.frame));
        //
        //        [_subViewScrollView addSubview:detail];
        ProjectDetailLeftView *left =[[ProjectDetailLeftView alloc]init];
        
        [_subViewScrollView addSubview:left];
        
        left.sd_layout
        .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        left.frame = CGRectMake(0, 0, SCREENWIDTH, left.height);
        [_heightArray addObject:[NSNumber numberWithFloat:left.height]];
        
        //实例化底部按钮视图
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-64 - 50, SCREENWIDTH, 50)];
        [_bottomView setBackgroundColor:[UIColor whiteColor]];
        _kefuBtn = [UIButton new];
        [_kefuBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-kefu"] forState:UIControlStateNormal];
        [_kefuBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-kefu"] forState:UIControlStateHighlighted];
        [_kefuBtn setTag:0];
        [_kefuBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_kefuBtn];
        [_kefuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_bottomView.mas_centerY);
            make.left.mas_equalTo(_bottomView.mas_left).offset(8);
            make.top.mas_equalTo(_bottomView.mas_top).offset(5);
            make.bottom.mas_equalTo(_bottomView.mas_bottom).offset(-5);
            make.width.mas_equalTo(100*WIDTHCONFIG);
        }];
        //认投按钮
        _investBtn = [UIButton new];
        [_investBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-rocket"] forState:UIControlStateNormal];
        [_investBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-rocket"] forState:UIControlStateHighlighted];
        [_investBtn setTag:1];
        [_investBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_investBtn];
        [_investBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_kefuBtn.mas_centerY);
            make.left.mas_equalTo(_kefuBtn.mas_right).offset(24*WIDTHCONFIG);
            make.right.mas_equalTo(_bottomView.mas_right).offset(-8*WIDTHCONFIG);
            make.height.mas_equalTo(_kefuBtn.mas_height);
        }];

//        [self.view addSubview:_bottomView];
        
        //实例化成员分页面
        member = [ProjectDetailMemberView instancetationProjectDetailMemberView];
        member.projectId = self.projectId;
        member.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, member.viewHeight);
        [_heightArray addObject:[NSNumber numberWithFloat:member.viewHeight]];
        [_subViewScrollView addSubview:member];
        
        
        
        ProjectDetailSceneView *scene =[[ProjectDetailSceneView alloc]initWithFrame:CGRectMake(2*SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT-CGRectGetMaxY(_titleScrollView.frame)-64)];
        scene.projectId = self.projectId;
        [_heightArray addObject:[NSNumber numberWithFloat: SCREENHEIGHT-CGRectGetMaxY(_titleScrollView.frame)-64 ]];
        [_subViewScrollView addSubview:scene];
        
        
    }
    
    return _subViewScrollView;
}

#pragma mark - 按钮数组
- (NSMutableArray *)btArray{
    
    if (!_btArray) {
        
        _btArray = [NSMutableArray array];
    }
    return _btArray;
}

#pragma mark- 切换按钮的点击事件
- (void)buttonAction:(UIButton *)sender{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _lineView.frame = CGRectMake(sender.frame.origin.x, _lineView.frame.origin.y, _lineView.frame.size.width, _lineView.frame.size.height);
    }];
    for (int i = 0; i<_titleArray.count; i++) {
        UIButton *bt = (UIButton *)[_titleScrollView viewWithTag:10+i];
        sender.tag == (10+i) ? [bt setTitleColor:selectTitleColor forState:UIControlStateNormal] : [bt setTitleColor:unselectTitleColor forState:UIControlStateNormal];
        
    }
    //子scrollView的偏移量
    NSLog(@"移动%f",SCREENWIDTH*(sender.tag-10));
    _subViewScrollView.contentOffset=CGPointMake(SCREENWIDTH*(sender.tag-10), 0);
    
    //重置子scrollView的大小  以及父scrollView的contentSize
    CGFloat valueY = CGRectGetMaxY(_titleScrollView.frame);
    switch (sender.tag) {
        case 10:
        {
            
            //            _subViewScrollView.frame = CGRectMake(0, valueY, SCREENWIDTH, [_heightArray[0] floatValue]);
            //            _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_subViewScrollView.frame));
            
            _subViewScrollView.frame = CGRectMake(0, valueY, SCREENWIDTH, [_heightArray[0] floatValue]);
            //                _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_subViewScrollView.frame));
            float  h = CGRectGetMaxY(_subViewScrollView.frame)+_titleScrollView.height+SCREENWIDTH*0.6+20;
            _scrollView.contentSize = CGSizeMake(0,h);
            
            NSLog(@"点击了第%ld个",sender.tag-10);
        }
            break;
        case 11:
        {
            _subViewScrollView.frame = CGRectMake(0, valueY, SCREENWIDTH, [_heightArray[1] floatValue]);
            _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_subViewScrollView.frame));
            NSLog(@"点击了第%ld个",sender.tag-10);
            
            
        }
            break;
        case 12:
        {
            _subViewScrollView.frame = CGRectMake(0, valueY, SCREENWIDTH, [_heightArray[2] floatValue]);
            _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_subViewScrollView.frame));
            NSLog(@"点击了第%ld个",sender.tag-10);
        }
            break;
        default:
            break;
    }

    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == _subViewScrollView) {
        
        CGFloat offSetX = scrollView.contentOffset.x;
        NSInteger index = offSetX/SCREENWIDTH;
        UIButton *bt = (UIButton *)[_scrollView viewWithTag:(index+10)];
        _lineView.frame = CGRectMake(bt.frame.origin.x, _lineView.frame.origin.y, _lineView.frame.size.width, _lineView.frame.size.height);
        [bt setTitleColor:selectTitleColor forState:UIControlStateNormal];
        
        _titleScrollView.contentOffset = CGPointMake(index/4*SCREENWIDTH, 0);
        
        for (int i = 0; i<_titleArray.count; i++) {
            UIButton *bt = (UIButton *)[_titleScrollView viewWithTag:10+i];
            10+index == (10+i) ? [bt setTitleColor:selectTitleColor forState:UIControlStateNormal] : [bt setTitleColor:unselectTitleColor forState:UIControlStateNormal];
            
        }
        
        //重置子scrollView的大小  以及父scrollView的contentSize
        CGFloat valueY = CGRectGetMaxY(_titleScrollView.frame);
        switch (index) {
            case 0:
            {
                
                _subViewScrollView.frame = CGRectMake(0, valueY, SCREENWIDTH, [_heightArray[0] floatValue]);
                //                _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_subViewScrollView.frame));
                float  h = CGRectGetMaxY(_subViewScrollView.frame)+_titleScrollView.height+SCREENWIDTH*0.6+20;
                _scrollView.contentSize = CGSizeMake(0,h);
                
            }
                break;
            case 1:
            {
                _subViewScrollView.frame = CGRectMake(0, valueY, SCREENWIDTH, [_heightArray[1] floatValue]);
                _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_subViewScrollView.frame));
                
                
                
            }
                break;
            case 2:
            {
                _subViewScrollView.frame = CGRectMake(0, valueY, SCREENWIDTH, [_heightArray[2] floatValue]);
                _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_subViewScrollView.frame));
                
            }
                break;
            default:
                break;
        }
    }
    
    
//    for(int i = 0; i< _subViewScrollView.subviews.count;i++){
//        NSLog(_subViewScrollView.description);
//        NSLog(_subViewScrollView.subviews[i].description);
//    }
    
}


-(void)calcuateLeftViewHeightNotification:(NSNotification *) notification{
    float h = [[notification.userInfo valueForKey:@"height"] floatValue];
    
    [_heightArray  replaceObjectAtIndex:0 withObject:[NSNumber numberWithFloat:h]];
    
    _subViewScrollView.frame = CGRectMake(0, CGRectGetMaxY(_titleScrollView.frame), SCREENWIDTH, h);
    //    _subViewScrollView.sd_layout
    //    .leftSpaceToView(self.view,0)
    //    .rightSpaceToView(self.view,0)
    //    .topSpaceToView(_titleScrollView,0)
    //    .heightIs(h)
    //    ;
    
    h = CGRectGetMaxY(_subViewScrollView.frame)+_titleScrollView.height+SCREENWIDTH*0.6+20;
    _scrollView.contentSize = CGSizeMake(0,h);
    //    _subViewScrollView.contentSize = CGSizeMake(0,CGRectGetMaxY(_subViewScrollView.frame));
    
    [self.view setupAutoHeightWithBottomView:_subViewScrollView bottomMargin:0];
}


#pragma mark - 底部按钮点击事件
-(void)btnClick:(UIButton*)btn
{
    if (btn.tag == 0) {
        NSLog(@"拨打电话");
    }
    if (btn.tag == 1) {
        NSLog(@"进入投资页面");
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent=NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    AppDelegate * delegate =(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [delegate.tabBar tabBarHidden:NO animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
