//
//  ProjectDetailLeftView.h
//  JinZhiT
//
//  Created by Eugene on 16/5/14.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectDetailLeftView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *topView; //上边阴影区
@property (nonatomic, strong) UIImageView * projectImage; // 项目头像
@property (nonatomic, strong) UILabel *projectName;    //项目名字
@property (nonatomic, strong) UIView *firstPartLine;   //第一条分隔线
@property (nonatomic, strong) UIImageView * statusImage; //项目状态图片
@property (nonatomic, strong) UIImageView * goalImage; //融资总额
@property (nonatomic, strong) UILabel * goalLabel;
@property (nonatomic, strong) UILabel * goalNumber;

@property (nonatomic, strong) UIImageView * achieveImage; //已融金额
@property (nonatomic, strong) UILabel * achieveLabel;
@property (nonatomic, strong) UILabel * achieveNumer;

@property (nonatomic, strong) UIImageView * timeImage; // 起止时间
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) UILabel * timeNumber;

@property (nonatomic, strong) UIImageView * addressImage; //所在地
@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) UILabel * addressNumber;

@property (nonatomic, strong) UILabel * contentLabel;   //简介label

@property (nonatomic, strong) UIButton * leftPhotoBtn;
@property (nonatomic, strong) UIButton * middlePhotoBtn;
@property (nonatomic, strong) UIButton * rightPhotoBtn;

@property (nonatomic, strong) UIButton * moreBtn;     //更多btn

@property (nonatomic, strong) UIView * secondPartLine; //第二条分隔线

@property (nonatomic, strong) UIImageView * teamImage; //团队头像
@property (nonatomic, strong) UILabel * teamLabel;     //团队label
@property (nonatomic, strong) UIView * thirdPartLine; //第三条分隔线
@property (nonatomic, strong) UIScrollView * scrollView; //团队滚动视图

@property (nonatomic, strong) UIView * fourPartLine; //第四条分隔线
@property (nonatomic, strong) UIButton * financialBtn; //财务状况
@property (nonatomic, strong) UILabel * financialLabel;

@property (nonatomic, strong) UIButton * raisefundsBtn; //融资方案
@property (nonatomic, strong) UILabel * raisefundsLabel;

@property (nonatomic, strong) UIButton * quitBtn; //退出渠道
@property (nonatomic, strong) UILabel * quitLabel;

@property (nonatomic, strong) UIButton * commerceBtn; //商业计划书
@property (nonatomic, strong) UILabel * commerceLabel;

@property (nonatomic, strong) UIButton * riskBtn; //风控报告
@property (nonatomic, strong) UILabel * riskLabel;

@property (nonatomic, strong) UIView * bottomView;  //最底层色块

-(CGFloat)calculateheight;

@end