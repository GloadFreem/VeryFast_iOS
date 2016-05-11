//
//  ProjectBannerView.h
//  JinZhiT
//
//  Created by Eugene on 16/5/11.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProjectBannerView;
@protocol ProjectBannerViewDelegate <NSObject>

@optional
//代理方法

-(void)transportProjectBannerView:(ProjectBannerView*)view andTagValue:(NSInteger)tagValue;

@end


@interface ProjectBannerView : UIView<UIScrollViewDelegate>


@property (assign, nonatomic) id<ProjectBannerViewDelegate> delegate;

@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) NSTimer * timer;
@property (strong, nonatomic) UIPageControl * pageControl;
@property (strong, nonatomic) UIView * coverView;//遮盖view
@property (strong, nonatomic) UIImageView * firstBottomImage;
@property (strong, nonatomic) UIImageView * secondBottomImage;
@property (strong, nonatomic) UILabel * firstLabel;
@property (strong, nonatomic) UILabel * secondLabel;
@property (strong, nonatomic) UIButton * leftBtn;
@property (strong, nonatomic) UIButton * rightBtn;

@property (strong, nonatomic) UIView * leftSliderBottomView;//左边下划线
@property (strong, nonatomic) UIView * rightSliderBottomView;//右边下划线

@property (strong, nonatomic) UIButton * selectedBtn;//当前选中btn
@property (assign, nonatomic) NSInteger selectedNum;//选中标识

-(void)relayoutWithModelArray:(NSArray*)array;
-(CGFloat)getCellHeight;

@end
