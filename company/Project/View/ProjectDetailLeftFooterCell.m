//
//  ProjectDetailLeftFooterCell.m
//  JinZhiT
//
//  Created by Eugene on 16/6/1.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailLeftFooterCell.h"

@implementation ProjectDetailLeftFooterCell

{
    UIScrollView *_scrollView;
    UIView *_topView;
    UIImageView *_teamImage;
    UILabel *_teamLabel;
    UIView *_partLine;
    UIView *_bottomView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
                [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

-(void)setup
{
    _topView = [UIView new];
    _topView.backgroundColor = colorGray;
    [self.contentView addSubview:_topView];
    
    _topView.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(10);
    
    UIImage *teamImage = [UIImage imageNamed:@"friends"];
    _teamImage = [[UIImageView alloc]initWithImage:teamImage];
    _teamImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_teamImage];
    
    _teamImage.sd_layout
    .widthIs(40)
    .leftSpaceToView(self.contentView,13)
    .topSpaceToView(_topView,15);
    
    _teamLabel = [UILabel new];
    _teamLabel.text = @"团队";
    _teamLabel.textColor = [UIColor blackColor];
    _teamLabel .textAlignment = NSTextAlignmentLeft;
    _teamLabel.font = BGFont(18);
    [self.contentView addSubview:_teamLabel];
    
    _teamLabel.sd_layout
    .centerYEqualToView(_teamImage)
    .leftSpaceToView(_teamImage,6)
    .heightIs(18);
    
    [_teamLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _partLine = [UIView new];
    _partLine.backgroundColor = colorGray;
    [self.contentView addSubview:_partLine];
    
    _partLine.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(_teamImage,10)
    .heightIs(0.5);
    
    
    _scrollView = [UIScrollView new];
    _scrollView.delegate = self;
    [self.contentView addSubview:_scrollView];
    
    _scrollView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(_partLine,10)
    .heightIs(120);
    
    
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = colorGray;
    [self.contentView addSubview:_bottomView];
    
    
    _bottomView.sd_layout
    .leftEqualToView(self.contentView)
    .topSpaceToView(_scrollView,15)
    .rightEqualToView(self.contentView)
    .heightIs(10);
    
    
    [self setupAutoHeightWithBottomView:_bottomView bottomMargin:0];
    //测试
    //    [self setModelArray:NULL];
    
}


-(void)setModelArray:(NSArray *)modelArray
{
    self.modelArray = modelArray;
    
    CGFloat leftSpace = 22.5 * WIDTHCONFIG;
    CGFloat width = 50 * WIDTHCONFIG;
    CGFloat space = (SCREENWIDTH - 45 * WIDTHCONFIG  - width * modelArray.count) /(modelArray.count - 1);
    NSInteger i = 0;
    for (; i < 5; i++) {
        UIButton *btn = [UIButton new];
        btn.frame = CGRectMake(leftSpace + (width + space) * i, 15, width, width);
        [_scrollView addSubview:btn];
        
        [btn setBackgroundImage:IMAGENAMED(@"Avatar-sample-165") forState:UIControlStateNormal];
        
        
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font = BGFont(12);
        label.numberOfLines = 2;
        [_scrollView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btn);
            make.top.mas_equalTo(btn.mas_bottom).offset(5);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(26);
        }];
        
        label.text = @"投资案例";
        
    }
}

@end
