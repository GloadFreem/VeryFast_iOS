//
//  CircleDetailHeaderView.m
//  JinZhiT
//
//  Created by Eugene on 16/6/1.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "CircleDetailHeaderView.h"

#import "PictureContainerView.h"

@implementation CircleDetailHeaderView
{
    UIView *_topView;
    UIImageView *_iconView;
    UILabel *_nameLabel;
    UILabel *_addressLabel;
    UILabel *_companyLabel;
    UIView *_shuView;
    UILabel *_positionLabel;
    UILabel *_timeLabel;
    UILabel *_contentLabel;
    PictureContainerView *_picContainerView;
    UIView *_middleView;
    
    UILabel *_praiseLabel;
    UIView *_bottomView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame: frame]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    _topView = [UIView new];
    [_topView setBackgroundColor:colorGray];
    
    _iconView = [UIImageView new];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    _nameLabel.textColor = color47;
    
    _addressLabel = [UILabel new];
    _addressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    _addressLabel.textColor = color74;
    
    _companyLabel = [UILabel new];
    _companyLabel.font = BGFont(12);
    _addressLabel.textColor = color74;
    
    _shuView = [UIView new];
    _shuView.backgroundColor = color74;
    
    _positionLabel = [UILabel new];
    _positionLabel.font = BGFont(12);
    _positionLabel.textColor = color74;
    
    _timeLabel = [UILabel new];
    _timeLabel.font = BGFont(12);
    _timeLabel.textColor = color74;
    
    _contentLabel = [UILabel new];
    _contentLabel.textColor = color47;
    _contentLabel.font = BGFont(15);
    _contentLabel.numberOfLines = 0;
    
    _picContainerView = [PictureContainerView new];
    
    _middleView = [UIView new];
    _middleView.backgroundColor = colorGray;
    
    _praiseBtn = [UIButton new];
    [_praiseBtn setImage:[UIImage imageNamed:@"icon_dianzan"] forState:UIControlStateNormal];
    [_praiseBtn addTarget:self action:@selector(praiseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _praiseLabel = [UILabel new];
    _praiseLabel.font = BGFont(12);
    _praiseLabel.textColor = color47;
    _praiseLabel.numberOfLines = 0;
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = colorGray;
    
    
    NSArray *views = @[_topView,_iconView, _nameLabel, _addressLabel, _companyLabel, _shuView, _positionLabel, _timeLabel, _contentLabel,_picContainerView,_middleView, _praiseBtn, _praiseLabel, _bottomView];
    
    [self sd_addSubviews:views];
    
    UIView *contentView = self;
    CGFloat margin = 8;
    
    _topView.sd_layout
    .leftEqualToView(contentView)
    .topEqualToView(contentView)
    .rightEqualToView(contentView)
    .heightIs(8);
    
    _iconView.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(_topView,margin)
    .widthIs(40)
    .heightIs(40);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconView,9)
    .topSpaceToView(contentView,8)
    .heightIs(17);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    _addressLabel.sd_layout
    .leftSpaceToView(_nameLabel,10)
    .bottomEqualToView(_nameLabel)
    .heightIs(12);
    [_addressLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    _companyLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel,8)
    .heightIs(12);
    [_companyLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    _shuView.sd_layout
    .leftSpaceToView(_companyLabel,5)
    .centerYEqualToView(_companyLabel)
    .heightIs(12)
    .widthIs(0.5);
    
    _positionLabel.sd_layout
    .leftSpaceToView(_shuView,5)
    .bottomEqualToView(_companyLabel)
    .heightIs(12);
    [_positionLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    _timeLabel.sd_layout
    .rightSpaceToView(contentView,margin)
    .bottomEqualToView(_companyLabel)
    .heightIs(12);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    _contentLabel.sd_layout
    .leftEqualToView(_iconView)
    .topSpaceToView(_iconView,12)
    .rightSpaceToView(contentView,margin)
    .autoHeightRatio(0);
    
    _picContainerView.sd_layout
    .leftEqualToView(_contentLabel);//已经在内部实现宽度和高度的自适应所以不需要在设置高度和宽度，top值是具体有无图片在setmodel方法设置
    
    _middleView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(10);
    
    _praiseBtn.sd_layout
    .leftSpaceToView(self, 12*WIDTHCONFIG)
    .topSpaceToView(_middleView, 10*HEIGHTCONFIG)
    .widthIs(16)
    .heightIs(16);
    
    _praiseLabel.sd_layout
    .leftSpaceToView(_praiseBtn, 10*WIDTHCONFIG)
    .topSpaceToView(_middleView, 13*HEIGHTCONFIG)
    .rightSpaceToView(self,20)
    .autoHeightRatio(0);
    
    _bottomView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(_praiseLabel, 13*HEIGHTCONFIG)
    .heightIs(10*HEIGHTCONFIG);
    
    
}
-(void)setModel:(CircleListModel *)model
{
    _model = model;
    
    _iconView.image = [UIImage imageNamed:model.iconNameStr];
    _nameLabel.text = model.nameStr;
    //防止单行文本label在重用时宽度计算不准的问题
    [_nameLabel sizeToFit];
    
    _addressLabel.text = model.addressStr;
    [_addressLabel sizeToFit];
    
    _companyLabel.text = model.companyStr;
    [_companyLabel sizeToFit];
    
    _positionLabel.text = model.positionStr;
    [_positionLabel sizeToFit];
    
    _timeLabel.text = model.timeSTr;
    [_timeLabel sizeToFit];
    
    _contentLabel.text = model.msgContent;
    _picContainerView.pictureStringArray = model.picNamesArray;
    
    
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10*HEIGHTCONFIG;
    }
    _picContainerView.sd_layout.topSpaceToView(_contentLabel,picContainerTopMargin);
    _praiseLabel.text = @"迪士尼代表动画角色，米老鼠的最初原型是他的设计伙伴伍培·艾沃克斯（iwerke)执笔设计的。维·史密斯和费洛伊德·戈特佛森创作的米老鼠的故事。米老鼠的形象设计出来以后，迪士尼开始用它来制作动画片";
    CGFloat height = [_praiseLabel.text commonStringHeighforLabelWidth:SCREENWIDTH -20 -12 -16 - 10 withFontSize:12];
    if (height > _contentLabel.font.lineHeight * 3) {
        _contentLabel.sd_layout.maxHeightIs(_contentLabel.font.lineHeight * 3);
    }else{
        _contentLabel.sd_layout.maxHeightIs(height);
    }
    
    [self setupAutoHeightWithBottomView:_bottomView bottomMargin:0];
}

-(void)praiseBtnClick
{
    if ([self.delegate respondsToSelector:@selector(didClickPraiseBtn:model:)]) {
        [self.delegate didClickPraiseBtn:self model:_model];
    }
}

@end
