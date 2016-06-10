//
//  ProjectDetailLeftTeamCell.m
//  JinZhiT
//
//  Created by Eugene on 16/6/1.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailLeftTeamCell.h"

@implementation ProjectDetailLeftTeamCell
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
    .widthIs(20)
    .heightIs(20)
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
    .leftSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,10)
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
    _modelArray = modelArray;
    
    NSInteger i = 0;
    CGFloat width = 50;
    CGFloat spaceMargin = 26;
    for (; i < 10; i++) {
        UIButton *btn = [UIButton new];
        btn.frame = CGRectMake(0 + i*(width + spaceMargin), 23, width, width);
        btn.layer.cornerRadius = 25;
        btn.layer.masksToBounds = YES;
        
        [btn setBackgroundImage:IMAGENAMED(@"Avatar-sample-165") forState:UIControlStateNormal];
        
        [_scrollView addSubview:btn];
        
        UILabel *nameLabel = [UILabel new];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textColor = color47;
        nameLabel.font = BGFont(13);
        
        nameLabel.text = @"王明";
        
        [_scrollView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(btn.mas_bottom).offset(12);
            make.centerX.mas_equalTo(btn);
            make.height.mas_equalTo(13);
        }];
        
        UILabel *positionLabel = [UILabel new];
        positionLabel.textAlignment = NSTextAlignmentCenter;
        positionLabel.textColor = color74;
        positionLabel.font = BGFont(11);
        
        positionLabel.text = @"经理";
        
        [_scrollView addSubview:positionLabel];
        [positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(nameLabel.mas_bottom).offset(5);
            make.centerX.mas_equalTo(btn);
            make.height.mas_equalTo(11);
        }];
        
    }
    CGFloat widOff = 30 + (width + spaceMargin) * i + 30;
    _scrollView.contentSize = CGSizeMake(widOff, 0);
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
