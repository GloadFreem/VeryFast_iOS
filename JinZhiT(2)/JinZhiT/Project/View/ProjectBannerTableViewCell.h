//
//  ProjectBannerTableViewCell.h
//  JinZhiT
//
//  Created by Eugene on 16/5/8.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProjectBannerTableViewCell;
@protocol ProjectBannerCellDelegate <NSObject>

@optional
//代理方法
-(void)transportProjectBannerTableViewCell:(ProjectBannerTableViewCell*)cell andTagValue:(NSInteger)tagValue;

@end


@interface ProjectBannerTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (assign, nonatomic) id<ProjectBannerCellDelegate> delegate;

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
@property (strong, nonatomic) UIView * selectedSlider;//当前选中下划线

-(void)relayoutWithModelArray:(NSArray*)array;
-(CGFloat)getCellHeight;


@end
