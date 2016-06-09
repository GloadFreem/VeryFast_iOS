//
//  CircleDetailCommentCell.m
//  JinZhiT
//
//  Created by Eugene on 16/6/1.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "CircleDetailCommentCell.h"

@implementation CircleDetailCommentCell
{
    UIImageView *_iconImage;
    UILabel *_namelabel;
    UILabel *_timelabel;
    UILabel *_contentLabel;
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
    _iconImage = [UIImageView new];
    _iconImage.layer.cornerRadius = 17;
    _iconImage.layer.masksToBounds = YES;
    
    _namelabel = [UILabel new];
    _namelabel.font = BGFont(13);
    _namelabel.textColor = [UIColor blackColor];
    _namelabel.textAlignment = NSTextAlignmentLeft;
    
    _timelabel = [UILabel new];
    _timelabel.font = BGFont(10);
    _timelabel.textColor = color74;
    _timelabel.textAlignment = NSTextAlignmentLeft;
    
    _contentLabel = [UILabel new];
    _contentLabel.font = BGFont(13);
    _contentLabel.textColor = color47;
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.numberOfLines = 0;
    
    NSArray *views = @[_iconImage, _namelabel, _timelabel, _contentLabel];
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    
    _iconImage.sd_layout
    .leftSpaceToView(contentView, 12*WIDTHCONFIG)
    .topSpaceToView(contentView, 12*HEIGHTCONFIG)
    .widthIs(35)
    .heightIs(35);
    
    _namelabel.sd_layout
    .leftSpaceToView(_iconImage, 10*WIDTHCONFIG)
    .topSpaceToView(contentView, 11*HEIGHTCONFIG)
    .heightIs(13);
    
    _timelabel.sd_layout
    .leftEqualToView(_namelabel)
    .topSpaceToView(_namelabel, 5*HEIGHTCONFIG)
    .heightIs(10);
    
    _contentLabel.sd_layout
    .leftEqualToView(_namelabel)
    .topSpaceToView(_timelabel, 10*HEIGHTCONFIG)
    .autoHeightRatio(0);
    
    
}

-(void)setModel:(CircleDetailCommentModel *)model
{
    _model = model;
    
    _iconImage.image = [UIImage imageNamed:model.iconImageStr];
    
    _namelabel.text = model.nameStr;
    [_namelabel sizeToFit];
    
    _timelabel.text = model.timeStr;
    [_timelabel sizeToFit];
    
    _contentLabel.text = model.contentStr;
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:15*HEIGHTCONFIG];
}

@end
