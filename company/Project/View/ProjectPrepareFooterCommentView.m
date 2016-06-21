//
//  ProjectPrepareFooterCommentView.m
//  company
//
//  Created by Eugene on 16/6/21.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectPrepareFooterCommentView.h"

@implementation ProjectPrepareFooterCommentView


-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
    
}

-(void)createUI
{
    
     UIView *view = [UIView new];
     view.frame = CGRectMake(0, 0, SCREENWIDTH, 50);
     view.backgroundColor = [UIColor whiteColor];
     [self addSubview:view];
     
     _commentImage= [UIImageView new];
     _commentImage.image = [UIImage imageNamed:@"comments"];
     _commentImage.contentMode = UIViewContentModeScaleAspectFill;
     _commentImage.size = _commentImage.image.size;
     [view addSubview:_commentImage];
    
    _commentImage.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(view,16);
    
     
     _commentLabel = [UILabel new];
     _commentLabel.text = @"在线交流";
     _commentLabel.textColor = [UIColor blackColor];
     _commentLabel.font = BGFont(18);
     _commentLabel.textAlignment = NSTextAlignmentLeft;
     [view addSubview:_commentLabel];
    
    _commentLabel.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(_commentImage,8)
    .heightIs(18);
    [_commentLabel setSingleLineAutoResizeWithMaxWidth:100];
    
     
     _commentNumber = [UILabel new];
     _commentNumber.textAlignment  = NSTextAlignmentLeft;
     _commentNumber.textColor = color47;
     _commentNumber.font = BGFont(14);
     //设置文字信息
     
     [view addSubview:_commentNumber];
    _commentNumber.sd_layout
    .bottomEqualToView(_commentLabel)
    .leftSpaceToView(_commentLabel,1)
    .heightIs(14);
    
     
     _moreImage = [UIImageView new];
     _moreImage.image = [UIImage imageNamed:@"youjinatou"];
     _moreImage.size = _moreImage.image.size;
     _moreImage.contentMode = UIViewContentModeScaleAspectFill;
     [view addSubview:_moreImage];
     _moreImage.sd_layout
     .centerYEqualToView(view)
     .rightSpaceToView(view,8);
    
     _moreBtn =[UIButton new];
     [_moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
     [_moreBtn setTitleColor:orangeColor forState:UIControlStateNormal];
     [_moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     _moreBtn.titleLabel.font = BGFont(14);
     [view addSubview:_moreBtn];
    
    _moreBtn.sd_layout
    .centerYEqualToView(view)
    .rightSpaceToView(_moreImage,5)
    .heightIs(15)
    .widthIs(64);
    
    _firstLine = [UIView new];
    _firstLine.backgroundColor  = [UIColor darkGrayColor];
    [view addSubview:_firstLine];
    _firstLine.sd_layout
    .leftEqualToView(view)
    .rightEqualToView(view)
    .heightIs(0.5)
    .bottomEqualToView(view);
    
    _firstIcon = [UIImageView new];
    _firstIcon.contentMode = UIViewContentModeScaleAspectFill;
    _firstIcon.layer.cornerRadius = 16.5;
    _firstIcon.layer.masksToBounds = YES;
    
    _firstName = [UILabel new];
    _firstName.font = BGFont(14);
    _firstName.textColor = [UIColor darkTextColor];
    _firstName.textAlignment = NSTextAlignmentLeft;
    
    _firstTime = [UILabel new];
    _firstTime.textAlignment = NSTextAlignmentLeft;
    _firstTime.textColor = [UIColor lightTextColor];
    _firstTime.font = BGFont(10);
    
    _firstContent = [UILabel new];
    _firstContent.textColor = color47;
    _firstContent.textAlignment = NSTextAlignmentLeft;
    _firstContent.font = BGFont(14);
    
    _secondLine = [UIView new];
    _secondLine.backgroundColor = colorGray;
    
    _secondIcon = [UIImageView new];
    _secondIcon.contentMode = UIViewContentModeScaleAspectFill;
    _secondIcon.layer.cornerRadius = 16.5;
    _secondIcon.layer.masksToBounds = YES;
    
    _secondName  = [UILabel new];
    _secondName.textColor = [UIColor darkTextColor];
    _secondName.textAlignment = NSTextAlignmentLeft;
    _secondName.font = BGFont(14);
    
    _secondTime = [UILabel new];
    _secondTime.textAlignment = NSTextAlignmentLeft;
    _secondTime.textColor = [UIColor lightTextColor];
    _secondTime.font = BGFont(10);
    
    _secondContent = [UILabel new];
    _secondContent.textColor = color47;
    _secondContent.textAlignment = NSTextAlignmentLeft;
    _secondContent.font = BGFont(14);
    
    _commentBtn = [UIButton new];
    [_commentBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-bianji"] forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
    NSArray *views = @[_firstIcon, _firstName, _firstTime, _firstContent, _secondLine, _secondIcon, _secondName, _secondTime, _secondContent, _commentBtn];
    [self sd_addSubviews:views];
    
    _firstIcon.sd_layout
    .leftSpaceToView(self,17*WIDTHCONFIG)
    .topSpaceToView(view,25)
    .widthIs(33)
    .heightIs(33);
    
    _firstName.sd_layout
    .leftSpaceToView(_firstIcon,10*WIDTHCONFIG)
    .topSpaceToView(view,23)
    .heightIs(14);
    [_firstName setSingleLineAutoResizeWithMaxWidth:100];
    
    _firstTime.sd_layout
    .leftEqualToView(_firstName)
    .topSpaceToView(_firstName,5)
    .heightIs(10);
    [_firstTime setSingleLineAutoResizeWithMaxWidth:100];
    
    _firstContent.sd_layout
    .leftEqualToView(_firstName)
    .topSpaceToView(_firstTime,11)
    .rightSpaceToView(self,10)
    .autoHeightRatio(0);
    
    _secondLine.sd_layout
    .leftSpaceToView(self,10)
    .rightSpaceToView(self,10)
    .heightIs(0.5)
    .topSpaceToView(_firstContent,19);
    
    _secondIcon.sd_layout
    .leftSpaceToView(self,17*WIDTHCONFIG)
    .topSpaceToView(_secondLine,12)
    .heightIs(33)
    .widthIs(33);
    
    _secondName.sd_layout
    .leftSpaceToView(_secondIcon,10*WIDTHCONFIG)
    .topSpaceToView(_secondLine,10)
    .heightIs(14);
    [_secondName setSingleLineAutoResizeWithMaxWidth:100];
    
    _secondTime.sd_layout
    .leftEqualToView(_secondName)
    .topSpaceToView(_secondName,5)
    .heightIs(10);
    [_secondTime setSingleLineAutoResizeWithMaxWidth:100];
    
    _secondContent.sd_layout
    .leftEqualToView(_secondName)
    .topSpaceToView(_secondTime,11)
    .rightSpaceToView(self,10)
    .autoHeightRatio(0);
    
    _commentBtn.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(_secondContent,8)
    .widthIs(80*WIDTHCONFIG)
    .heightIs(35);
 
    [self setupAutoHeightWithBottomView:_commentBtn bottomMargin:20];
}



#pragma markmoreBtn  点击事件
-(void)moreBtnClick:(UIButton*)btn
{
    
}
#pragma makr -评论点击
-(void)commentClick:(UIButton*)btn
{
    
}
@end
