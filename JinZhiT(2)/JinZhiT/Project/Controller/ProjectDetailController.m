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
#import "ProjectDetailFirstHeaderView.h"
#import "ProjectDetailMemberView.h"

#define defaultLineColor [UIColor blueColor]
#define selectTitleColor [UIColor orangeColor]
#define unselectTitleColor [UIColor blackColor]
#define titleFont [UIFont systemFontOfSize:16]


@interface ProjectDetailController ()<ProjectDetailBannerViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) UIScrollView *titleScrollView; //切换按钮
@property (nonatomic,strong) NSArray *titleArray;   // 切换按钮数组
@property (nonatomic,strong) UIView *lineView;      // 下划线视图
@property (nonatomic,strong) UIScrollView *subViewScrollView;   // 下边子滚动视图
@property (nonatomic,strong) NSMutableArray *heightArray;      // subviewScrollView子视图高度数组
@property (nonatomic,strong) NSMutableArray *btArray;   //点击切换按钮数组

@end

@implementation ProjectDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _heightArray = [NSMutableArray array];                  //子视图高度数组
    
    _scrollView.bounces = NO;                               //关闭弹性
    
    //广告栏视图
    ProjectDetailBannerView * bannerView= [[ProjectDetailBannerView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH*0.6)];
    NSArray * array = [NSArray array];
    [bannerView relayoutWithModelArr:array];
    
    [_scrollView addSubview:bannerView];                     //添加广告栏
    
    _titleArray = @[@"详情",@"成员",@"现场"];
    _lineColor = [UIColor orangeColor];
    _type = 0;
    [_scrollView addSubview:self.titleScrollView];          //添加点击按钮
    [_scrollView addSubview:self.subViewScrollView];        //添加最下边scrollview


    
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
        
        //        _subViewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-0.75*kScreenWidth-40)];
        //        _subViewScrollView.backgroundColor = [UIColor greenColor];
        _subViewScrollView = [[UIScrollView alloc]init];
        _subViewScrollView.frame = CGRectMake(0, CGRectGetMaxY(_titleScrollView.frame), SCREENWIDTH, 800);

        _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_subViewScrollView.frame));
        
        _subViewScrollView.showsHorizontalScrollIndicator = NO;
        _subViewScrollView.showsVerticalScrollIndicator = NO;
        _subViewScrollView.contentSize = CGSizeMake(SCREENWIDTH*_titleArray.count, 0);
        _subViewScrollView.delegate = self;
        _subViewScrollView.alwaysBounceVertical = NO;
        _subViewScrollView.pagingEnabled = YES;
        //方向锁
        _subViewScrollView.directionalLockEnabled = YES;
        //加进去的测试高度数据
        NSNumber *aNumber = [NSNumber numberWithFloat:800];
        [_heightArray addObject:aNumber];
        NSNumber *bNumber = [NSNumber numberWithFloat:400];
        [_heightArray addObject:bNumber];
        NSNumber *cNumber = [NSNumber numberWithFloat:SCREENHEIGHT - CGRectGetMaxY(_titleScrollView.frame)];
        [_heightArray addObject:cNumber];
        
                NSArray *colorArr = @[[UIColor lightGrayColor],[UIColor cyanColor],[UIColor greenColor]];
                for (int i = 0; i<_titleArray.count; i++) {
        
                    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(i*SCREENWIDTH, 0, SCREENWIDTH, [_heightArray[i] floatValue])];
                    subview.backgroundColor = colorArr[i%colorArr.count];
                    [_subViewScrollView addSubview:subview];
                }
       
        
        //加载自定义视图
        //详情视图
//        ProjectDetailFirstHeaderView * detailView = [ProjectDetailFirstHeaderView instancetypeProjectDetailFirstHeaderView];
//        _detailHeight = detailView.viewHeight;//当前视图的高度等于内部视图的高度
//        _viewHeight = _detailHeight;
//        detailView.frame = CGRectMake(0, 0, SCREENWIDTH, detailView.viewHeight);
//        //_subViewScrollView的尺寸
//        _subViewScrollView.frame = CGRectMake(0, 0.6*SCREENWIDTH+64, SCREENWIDTH, 600);
//        [_subViewScrollView addSubview:detailView];
//        //成员视图
//        ProjectDetailMemberView * memberView =[ProjectDetailMemberView instancetationProjectDetailMemberView];
//        _memberHeight = memberView.viewHeight;
//        memberView.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, memberView.viewHeight);
//        [_subViewScrollView addSubview:memberView];
//        
//        UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(2*SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT-0.6*SCREENWIDTH-40)];
//        subview.backgroundColor  = [UIColor greenColor];
//        [_subViewScrollView addSubview:subview];
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
    _subViewScrollView.contentOffset=CGPointMake(SCREENWIDTH*(sender.tag-10), 0);
    //重置子scrollView的大小  以及父scrollView的contentSize
    CGFloat valueY = CGRectGetMaxY(_titleScrollView.frame);
    switch (sender.tag) {
        case 10:
        {
            
            _subViewScrollView.frame = CGRectMake(0, valueY, SCREENWIDTH, [_heightArray[0] floatValue]);
            _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_subViewScrollView.frame));
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
                _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_subViewScrollView.frame));
                
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
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent=NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
