//
//  ProjectDetailFirstHeaderView.h
//  JinZhiT
//
//  Created by Eugene on 16/5/13.
//  Copyright © 2016年 Eugene. All rights reserved.
//


//---------------------------------首页详情页详情分页视图--------------------------


#import <UIKit/UIKit.h>

@interface ProjectDetailFirstHeaderView : UIView<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *projectNameLabel;//项目名称
@property (weak, nonatomic) IBOutlet UILabel *goalLabel;//融资总额

@property (weak, nonatomic) IBOutlet UILabel *getMoneyLabel;//已融金额
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//起止时间

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;//所在地
@property (weak, nonatomic) IBOutlet UILabel *textLabel;//介绍内容



@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (weak, nonatomic) IBOutlet UIImageView *statusImage;//右上角状态图片
@property (weak, nonatomic) IBOutlet UIView *sliderView;//进度条View
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



#pragma mark- 最下边一排按钮
@property (weak, nonatomic) IBOutlet UIButton *financialBtn;//财务btn
@property (weak, nonatomic) IBOutlet UILabel *financialLabel;//财务label
@property (weak, nonatomic) IBOutlet UIButton *raiseFundsBtn;//融资btn
@property (weak, nonatomic) IBOutlet UILabel *raiseFundsLabel;//融资label
@property (weak, nonatomic) IBOutlet UIButton *quitBtn;//退出btn
@property (weak, nonatomic) IBOutlet UILabel *quitLabel;//退出label
@property (weak, nonatomic) IBOutlet UIButton *commerceBtn;//商业btn
@property (weak, nonatomic) IBOutlet UILabel *commerceLabel;//商业label
@property (weak, nonatomic) IBOutlet UIButton *riskBtn;//风控btn
@property (weak, nonatomic) IBOutlet UILabel *riskLabel;//风控label
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (assign, nonatomic) CGFloat viewHeight;


#pragma mark- 实例化视图
+(ProjectDetailFirstHeaderView*)instancetypeProjectDetailFirstHeaderView;
@end
