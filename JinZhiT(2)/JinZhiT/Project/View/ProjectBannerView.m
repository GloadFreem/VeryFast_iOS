//
//  ProjectBannerView.m
//  JinZhiT
//
//  Created by Eugene on 16/5/11.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectBannerView.h"

#import "MeasureTool.h"
#import "ProjectBannerModel.h"
#define kADcount 4
#define kImageCount 4
#define SCROLLVIEWHEIGHT SCREENWIDTH*0.75
#define kPAGEX SCREENWIDTH*0.9
#define kPAGEY SCROLLVIEWHEIGHT*0.9
#define kPAGEWIDTH 0
#define kPAGEHEIGHT 0
#define kCOVERY 180
#define kCOVERHEIGHT 50
#define kLeftSpace 10

@implementation ProjectBannerView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

#pragma mark - 自定义布局
-(void)createUI
{
    [self setBackgroundColor:[UIColor whiteColor]];
    //广告栏
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREENWIDTH ,SCROLLVIEWHEIGHT)];
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    //遮盖
    _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, kCOVERY, SCREENWIDTH, kCOVERHEIGHT)];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0.5;
    [self addSubview:_coverView];
    //圆圈
    UIImage * bottom = [UIImage imageNamed:@"椭圆-4-拷贝-2"];
    _firstBottomImage = [[UIImageView alloc]initWithImage:bottom];
    _firstBottomImage.frame = CGRectMake(kLeftSpace, kCOVERY, 46, 46);
    //设置圆角
    _firstBottomImage.layer.cornerRadius = bottom.size.width/2;
    _firstBottomImage.layer.masksToBounds = YES;
    //自适应图片宽高比例
    _firstBottomImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_firstBottomImage];
    
    UIImage * second = [UIImage imageNamed:@"椭圆-4-拷贝"];
    _secondBottomImage = [[UIImageView alloc]initWithImage:second];
    _secondBottomImage.center = _firstBottomImage.center;
    _secondBottomImage.layer.cornerRadius = second.size.width/2;
    _secondBottomImage.layer.masksToBounds = YES;
    _secondBottomImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_secondBottomImage];
    
    //firstLabel
    _firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_secondBottomImage.frame)+15, _coverView.frame.origin.y+8, 100, 17)];
    _firstLabel.font = [UIFont systemFontOfSize:17];
    _firstLabel.text = @"逸景营地";
    _firstLabel.textColor = [UIColor whiteColor];
    _firstLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_firstLabel];
    //第二个label
    _secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(_firstLabel.frame.origin.x, CGRectGetMaxY(_firstLabel.frame)+9 , 200, 12)];
    _secondLabel.font =[UIFont systemFontOfSize:12];
    _secondLabel.text = @"新三板VR企业在2015年下半年";
    _secondLabel.textColor = [UIColor whiteColor];
    _secondLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_secondLabel];
    //第一个button
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_coverView.frame), SCREENWIDTH/2, 47)];
    //    [_leftBtn setBackgroundColor:[UIColor blackColor]];
    [_leftBtn setTag:20];
    [_leftBtn setTitle:@"路演项目" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [_leftBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    ;
    [_leftBtn setSelected:YES];
    
    _selectedBtn = _leftBtn;
    
    [self addSubview:_leftBtn];
    //左边的下划线
    //下划线的宽
    CGFloat sliderWidth = [_leftBtn.titleLabel.text commonStringWidthForFont:19];
    _leftSliderBottomView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH/4-sliderWidth/2, CGRectGetMaxY(_leftBtn.frame)-3,sliderWidth, 3)];
    //    [_leftSliderBottomView setBackgroundColor:[UIColor orangeColor]];
    _leftSliderBottomView.alpha = 0.8;
    [self addSubview:_leftSliderBottomView];
    
    
    
    //第二个button
    _rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH/2,_leftBtn.frame.origin.y, SCREENWIDTH/2, 47)];
    [_rightBtn setTitle:@"预选项目" forState:UIControlStateNormal];
    [_rightBtn setTag:21];
    [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    //    [_rightBtn setBackgroundColor:[UIColor blackColor]];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [_rightBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtn];
    
    //右边下划线
    _rightSliderBottomView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH*0.75-sliderWidth/2, CGRectGetMaxY(_rightBtn.frame)-3, sliderWidth, 3)];
//    NSLog(@"%f",_rightSliderBottomView.frame.size.width);
    //    [_rightSliderBottomView setBackgroundColor:[UIColor orangeColor]];;
    _rightSliderBottomView.alpha = 0.8;
    [self addSubview:_rightSliderBottomView];
    
    
    //页面控制器
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kPAGEX, kPAGEY, kPAGEWIDTH, kPAGEHEIGHT)];
    _pageControl.numberOfPages =kImageCount;
    //    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self addSubview:_pageControl];
    
    //设置默认显示btn
    _selectedBtn.tag = 20;
}

#pragma mark -重写setter方法
-(void)setSelectedNum:(NSInteger)selectedNum
{
    _selectedNum = selectedNum;
    [self setColorWithNum:_selectedNum];
    
}

#pragma mark -设置下划线的颜色
-(void)setColorWithNum:(NSInteger)num
{
    if (num == 20) {
        [_leftSliderBottomView setBackgroundColor:[UIColor orangeColor]];
        [_rightSliderBottomView setBackgroundColor:[UIColor whiteColor]];
    }else{
        [_leftSliderBottomView setBackgroundColor:[UIColor whiteColor]];
        [_rightSliderBottomView setBackgroundColor:[UIColor orangeColor]];
    }
}
#pragma mark- button点击事件
-(void)buttonClick:(UIButton*)button
{
    _selectedBtn.selected =!_selectedBtn.selected;
    button.selected = YES;
    [self setColorWithNum:button.tag];
    _selectedBtn = button;
    
    
    if ([self.delegate respondsToSelector:@selector(transportProjectBannerView:andTagValue:)]) {
//        NSLog(@"代理方法");
        [self.delegate transportProjectBannerView:self andTagValue:button.tag];
    }
}

#pragma mark- cell刷新数据
-(void)relayoutWithModelArray:(NSArray *)array
{
    NSInteger i =0;
    for (; i<4; i++) {
        //        ProjectBannerModel * model =(ProjectBannerModel*)array[i];
        UIButton * btn = [[UIButton alloc]init];
        
//        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0+i*SCREENWIDTH, 0, SCREENWIDTH, SCROLLVIEWHEIGHT);
        [btn setBackgroundImage:[UIImage imageNamed:@"c9d8be32534701.568974395e076"] forState:UIControlStateNormal];
        [_scrollView addSubview:btn];
        
        if (i==0) {
            UIButton * btn =[[UIButton alloc]init];
            
            btn.frame = CGRectMake(4*SCREENWIDTH, 0, SCREENWIDTH, SCROLLVIEWHEIGHT);
            [btn setBackgroundImage:[UIImage imageNamed:@"c9d8be32534701.568974395e076"] forState:UIControlStateNormal];
            [_scrollView addSubview:btn];
            
        }
    }
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH * i, 0);
    [self createTimer];
    [_timer setFireDate:[NSDate distantPast]];
}

#pragma mark- 创建Timer
-(void)createTimer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
    }else{
        [_timer setFireDate:[NSDate distantPast]];
    }
}

-(void)runTimer
{
    int page = _scrollView.contentOffset.x/SCREENWIDTH;
    page++;
    _pageControl.currentPage = page;
    [_scrollView setContentOffset:CGPointMake(page*SCREENWIDTH, 0) animated:YES];
}
#pragma mark -scrollView 页面控制联动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/SCREENWIDTH;
    if (page==4) {
        scrollView.contentOffset=CGPointZero;
        _pageControl.currentPage=0;
    }else{
        _pageControl.currentPage=page;
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int page=_scrollView.contentOffset.x/SCREENWIDTH;
    
    if (page==4) {
        _pageControl.currentPage=0;
        _scrollView.contentOffset=CGPointZero;
    }
}


@end
