//
//  ProjectDetailLeftView.m
//  JinZhiT
//
//  Created by Eugene on 16/5/14.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailLeftView.h"
#import "MeasureTool.h"
@implementation ProjectDetailLeftView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}


#pragma mark -创建内部视图
-(void)createUI
{
    //项目头像
    UIImage * projectImage = [UIImage imageNamed:@"drafts"];
    _projectImage = [[UIImageView alloc]initWithImage:projectImage];
    _projectImage.contentMode = UIViewContentModeScaleAspectFit;

    [self addSubview:_projectImage];
    [_projectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.top.mas_equalTo(13);
    }];
    //项目名字
    
    _projectName = [[UILabel alloc]init];
    _projectName.textColor = [UIColor blackColor];
    _projectName.font = [UIFont systemFontOfSize:18];
    _projectName.text=@"逸景营地";
    _projectName.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_projectName];
    [_projectName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_projectImage.mas_right).with.offset(6);
        make.centerY.mas_equalTo(_projectImage);
        make.height.mas_equalTo(@18);
    }];
    //第一条分隔线
    _firstPartLine = [[UIView alloc]init];
    _firstPartLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_firstPartLine];
    [_firstPartLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_projectImage.mas_bottom).with.offset(13);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(@1);
    }];
    //融资总额
    UIImage * goalImage = [UIImage imageNamed:@"iconfont-jine"];
    _goalImage = [[UIImageView alloc]initWithImage:goalImage];
    _goalImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_goalImage];
    [_goalImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(_firstPartLine.mas_bottom).offset(19);
    }];
    _goalLabel = [[UILabel alloc]init];
    _goalLabel.textColor = [UIColor darkGrayColor];
    _goalLabel.font = [UIFont systemFontOfSize:14];
    _goalLabel.textAlignment = NSTextAlignmentLeft;
    _goalLabel.text = @"融资总额";
    [self addSubview:_goalLabel];
    [_goalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_goalImage);
        make.left.mas_equalTo(_goalImage.mas_right).offset(4);
        make.height.mas_equalTo(@14);
    }];
    _goalNumber = [[UILabel alloc]init];
    _goalNumber.textColor = [UIColor blackColor];
    _goalNumber.font = [UIFont systemFontOfSize:14];
    _goalNumber.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_goalNumber];
    [_goalNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_goalImage);
        make.left.mas_equalTo(_goalLabel.mas_right).offset(14);
        make.height.mas_equalTo(@14);
    }];
    //已融金额
    UIImage * achieveImage = [UIImage imageNamed:@"iconfont-rong"];
    _achieveImage = [[UIImageView alloc]initWithImage:achieveImage];
    _achieveImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_achieveImage];
    [_achieveImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_goalImage);
        make.top.mas_equalTo(_goalLabel.mas_bottom).offset(20);
    }];
    _achieveLabel = [[UILabel alloc]init];
    _achieveLabel.text = @"已融金额";
    _achieveLabel.textColor = [UIColor darkGrayColor];
    _achieveLabel.font = [UIFont systemFontOfSize:14];
    _achieveLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_achieveLabel];
    [_achieveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_achieveImage.mas_right).offset(4);
        make.centerY.equalTo(_achieveImage);
        make.height.mas_equalTo(@14);
    }];
    _achieveNumer = [[UILabel alloc]init];
    _achieveNumer.textColor = [UIColor blackColor];
    _achieveNumer.textAlignment = NSTextAlignmentLeft;
    _achieveNumer.font = [UIFont systemFontOfSize:14];
    [self addSubview:_achieveNumer];
    [_achieveNumer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_achieveLabel.mas_right).offset(14);
        make.centerY.equalTo(_achieveImage);
        make.height.mas_equalTo(@14);
    }];
    //起止时间
    UIImage * timeImage = [UIImage imageNamed:@"iconfont-shengyushijian"];
    _timeImage = [[UIImageView alloc]initWithImage:timeImage];
    _timeImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_timeImage];
    [_timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_goalImage);
        make.top.mas_equalTo(_achieveImage.mas_bottom).offset(20);
    }];
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.text = @"起止时间";
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.textColor = [UIColor darkGrayColor];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeImage.mas_right).offset(4);
        make.centerY.equalTo(_timeImage);
        make.height.mas_equalTo(@14);
    }];
    _timeNumber = [[UILabel alloc]init];
    _timeNumber.textColor =[UIColor blackColor];
    _timeNumber.textAlignment = NSTextAlignmentLeft;
    _timeNumber.font =[UIFont systemFontOfSize:14];
    [self addSubview:_timeNumber];
    [_timeNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLabel.mas_right).offset(14);
        make.centerY.equalTo(_timeImage);
        make.height.mas_equalTo(@14);
    }];
    //所在地
    UIImage * addressImage = [UIImage imageNamed:@"地址"];
    _addressImage = [[UIImageView alloc]initWithImage:addressImage];
    _addressImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_addressImage];
    [_addressImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_timeImage.mas_bottom).offset(20);
        make.centerX.mas_equalTo(_timeImage);
    }];
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.text = @"所在地";
    _addressLabel.textColor = [UIColor darkGrayColor];
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    _addressLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_addressLabel];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_addressImage.mas_right).offset(4);
        make.centerY.equalTo(_addressImage);
        make.height.mas_equalTo(@14);
    }];
    _addressNumber = [[UILabel alloc]init];
    _addressNumber.textColor = [UIColor blackColor];
    _addressNumber.textAlignment = NSTextAlignmentLeft;
    _addressNumber.font =[UIFont systemFontOfSize:14];
    [self addSubview:_addressNumber];
    [_addressNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeNumber.mas_left);
        make.centerY.equalTo(_addressImage);
        make.height.mas_equalTo(@14);
    }];
    
    //contentlabel
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.textColor = [UIColor darkGrayColor];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.numberOfLines = 3;
    [_contentLabel sizeToFit];
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(30);
        make.top.mas_equalTo(_addressImage.mas_bottom).offset(23);
    }];
    //照片Btn
    CGFloat btnWidth = (SCREENWIDTH - 40*2-10)/3;
    CGFloat btnHeight = 0.83*btnWidth;
    _leftPhotoBtn = [[UIButton alloc]init];
    [self addSubview:_leftPhotoBtn];
    _middlePhotoBtn = [[UIButton alloc]init];
    [self addSubview:_middlePhotoBtn];
    _rightPhotoBtn = [[UIButton alloc]init];
    [self addSubview:_rightPhotoBtn];
    [_leftPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(_contentLabel.mas_bottom).offset(13);
        make.centerY.mas_equalTo(@[_middlePhotoBtn,_rightPhotoBtn]);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
    }];
    [_middlePhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
        make.left.mas_equalTo(_leftPhotoBtn.mas_right).offset(5);
    }];
    [_rightPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
        make.left.mas_equalTo(_middlePhotoBtn.mas_right).offset(5);
    }];
    
    //更多btn
    _moreBtn = [[UIButton alloc]init];
    _moreBtn.contentMode = UIViewContentModeScaleAspectFit;
    [_moreBtn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(_middlePhotoBtn.mas_bottom).offset(12);
    }];
    //第二条分隔线
    _secondPartLine = [[UIView alloc]init];
    _secondPartLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_secondPartLine];
    [_secondPartLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_moreBtn.mas_bottom).offset(2);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(@10);
    }];
    //团队头像
    UIImage * teamImage = [UIImage imageNamed:@"friends"];
    _teamImage = [[UIImageView alloc]initWithImage:teamImage];
    _teamImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_teamImage];
    [_teamImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.top.mas_equalTo(_secondPartLine.mas_bottom).offset(15);
    }];
    _teamLabel = [[UILabel alloc]init];
    _teamLabel.text = @"团队";
    _teamLabel.textColor = [UIColor blackColor];
    _teamLabel.textAlignment = NSTextAlignmentLeft;
    _teamLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:_teamLabel];
    [_teamLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_teamImage);
        make.left.mas_equalTo(_teamImage.mas_right).offset(6);
        make.height.mas_equalTo(@18);
    }];
    //第三条分隔线
    _thirdPartLine = [[UIView alloc]init];
    _thirdPartLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_thirdPartLine];
    [_thirdPartLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_teamImage.mas_bottom).offset(10);
        make.height.mas_equalTo(@1);
    }];
    //团队滚动视图
    _scrollView = [[UIScrollView alloc]init];
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_thirdPartLine.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(@120);
    }];
    //第四条分隔线
    _fourPartLine = [[UIView alloc]init];
    _fourPartLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_fourPartLine];
    [_fourPartLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(@10);
    }];
    //财务状况
    _financialBtn = [[UIButton alloc]init];
    [_financialBtn setBackgroundImage:[UIImage imageNamed:@"Bar-chart"] forState:UIControlStateNormal];
//    _financialBtn.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_financialBtn];
    
    //融资
    _raisefundsBtn = [[UIButton alloc]init];
    [_raisefundsBtn setBackgroundImage:[UIImage imageNamed:@"Pie-chart"] forState:UIControlStateNormal];
    //    _raisefundsBtn.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_raisefundsBtn];
    
    //退出渠道
    _quitBtn = [[UIButton alloc]init];
    [_quitBtn setBackgroundImage:[UIImage imageNamed:@"Loop"] forState:UIControlStateNormal];
    //    _quitBtn.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_quitBtn];
    
    //商业计划书
    _commerceBtn = [[UIButton alloc]init];
    [_commerceBtn setBackgroundImage:[UIImage imageNamed:@"Open-book"] forState:UIControlStateNormal];
    //    _commerceBtn.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_commerceBtn];
    
    //风控报告
    _riskBtn = [[UIButton alloc]init];
    [_riskBtn setBackgroundImage:[UIImage imageNamed:@"Documents"] forState:UIControlStateNormal];
    //    _riskBtn.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_riskBtn];
    
    //退出渠道
    [_quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_fourPartLine.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(50, 50));
        
    }];
    //融资
    [_raisefundsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_quitBtn);
        make.right.mas_equalTo(_quitBtn.mas_left).offset(-20);
//        make.size.mas_equalTo(CGSizeMake(50, 50));
        
        
    }];
    //财务
    [_financialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_quitBtn);
        make.right.mas_equalTo(_raisefundsBtn.mas_left).offset(-20);
//        make.size.mas_equalTo(CGSizeMake(50, 50));
        
    }];
    //商业
    [_commerceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_quitBtn);
        make.left.mas_equalTo(_quitBtn.mas_right).offset(20);
//        make.size.mas_equalTo(CGSizeMake(50, 50));
        
    }];
    //风险
    [_riskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_commerceBtn);
        make.left.mas_equalTo(_commerceBtn.mas_right).offset(20);
//        make.size.mas_equalTo(CGSizeMake(50, 50));
        
    }];
    
    _financialLabel = [[UILabel alloc]init];
    _financialLabel.text = @"财务\n状况";
    _financialLabel.numberOfLines = 2;
    _financialLabel.textAlignment = NSTextAlignmentCenter;
    _financialLabel.textColor = [UIColor darkGrayColor];
    _financialLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_financialLabel];
    [_financialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_financialBtn.mas_bottom).offset(5);
        make.centerX.mas_equalTo(_financialBtn);
        make.height.mas_equalTo(@25);
    }];
    
    
   
    _raisefundsLabel = [[UILabel alloc]init];
    _raisefundsLabel.text = @"融资\n方案";
    _raisefundsLabel.numberOfLines =2;
    _raisefundsLabel.textColor  = [UIColor darkGrayColor];
    _raisefundsLabel.textAlignment = NSTextAlignmentCenter;
    _raisefundsLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_raisefundsLabel];
    [_raisefundsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_raisefundsBtn.mas_bottom).offset(5);
        make.centerX.mas_equalTo(_raisefundsBtn);
        make.height.mas_equalTo(@25);
    }];
    
   
    _quitLabel = [[UILabel alloc]init];
    _quitLabel.text = @"退出\n渠道";
    _quitLabel.numberOfLines  = 2;
    _quitLabel.textColor = [UIColor darkGrayColor];
    _quitLabel.textAlignment = NSTextAlignmentCenter;
    _quitLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_quitLabel];
    [_quitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_quitBtn.mas_bottom).offset(5);
        make.centerX.mas_equalTo(_quitBtn);
        make.height.mas_equalTo(@25);
    }];
    
    
    _commerceLabel = [[UILabel alloc]init];
    _commerceLabel.text = @"商业\n计划书";
    _commerceLabel.numberOfLines =2;
    _commerceLabel.font = [UIFont systemFontOfSize:12];
    _commerceLabel.textColor = [UIColor darkGrayColor];
    _commerceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_commerceLabel];
    [_commerceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_commerceBtn);
        make.top.mas_equalTo(_commerceBtn.mas_bottom).offset(5);
        make.height.mas_equalTo(@25);
    }];
  
    
    _riskLabel = [[UILabel alloc]init];
    _riskLabel.text = @"风控\n报告";
    _riskLabel.numberOfLines = 2;
    _riskLabel.font = [UIFont systemFontOfSize:12];
    _riskLabel.textAlignment = NSTextAlignmentCenter;
    _riskLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_riskLabel];
    [_riskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_riskBtn.mas_bottom).offset(5);
        make.centerX.mas_equalTo(_riskBtn);
        make.height.mas_equalTo(@25);
    }];
    //最底层色块
    _bottomView = [[UIView alloc]init];
    [_bottomView setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_financialLabel.mas_bottom).offset(20);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(@10);
    }];
}

#pragma mark- btnAction
-(void)btnClick:(UIButton*)btn
{
    _contentLabel.numberOfLines  = 0;
    [_contentLabel sizeToFit];
}

#pragma mark - 计算高度
-(CGFloat)calculateheight
{
    return CGRectGetMaxY(_bottomView.frame)+49;
}

@end
