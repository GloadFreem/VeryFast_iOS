//
//  ProjectPreparePhotoCell.m
//  company
//
//  Created by Eugene on 16/6/17.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectPreparePhotoCell.h"
#import "PictureContainerView.h"

CGFloat ___maxContentLabelHeight = 0; //根据具体font来定

@implementation ProjectPreparePhotoCell
{
    UIImageView *_iconImage;
    UILabel *_projectLabel;
    UIView *_partLine;
    
    UILabel *_contentLabel;
    PictureContainerView *_picContainerView;   //照片容器
    UIButton *_moreBtn;
    BOOL _shouldOpen;
    
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
    _shouldOpen = NO;
    
    //项目图标
    UIImage *projectImage = [UIImage imageNamed:@"drafts"];
    _iconImage = [[UIImageView alloc]initWithImage:projectImage];
    
    //项目名字
    _projectLabel  = [UILabel new];
    _projectLabel.textColor = [UIColor blackColor];
    _projectLabel.font = BGFont(18);
    
    _projectLabel.textAlignment = NSTextAlignmentLeft;
    
    //第一条分隔线
    _partLine = [UIView new];
    _partLine.backgroundColor  = colorGray;
    
    //项目简介
    _contentLabel = [UILabel new];
    _contentLabel.textColor = color74;
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.font = BGFont(14);
    if (___maxContentLabelHeight == 0) {
        ___maxContentLabelHeight = _contentLabel.font.lineHeight * 3;
    }
    
    //图片
    _picContainerView = [PictureContainerView new];
    _picContainerView.backgroundColor = [UIColor redColor];
    
    //morebtn
    _moreBtn = [UIButton new];
    [_moreBtn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *views = @[_iconImage, _projectLabel, _partLine, _contentLabel, _picContainerView, _moreBtn];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    
    _iconImage.sd_layout
    .leftSpaceToView(contentView,13)
    .topSpaceToView(contentView,13)
    .widthIs(16)
    .heightIs(20);
    
    _projectLabel.sd_layout
    .leftSpaceToView(_iconImage,6)
    .centerYEqualToView(_iconImage)
    .heightIs(18);
    [_projectLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    _partLine.sd_layout
    .leftSpaceToView(contentView,0)
    .topSpaceToView(_iconImage,13)
    .rightSpaceToView(contentView,0)
    .heightIs(0.5);
    
    _contentLabel.sd_layout
    .leftSpaceToView(contentView,30)
    .rightSpaceToView(contentView,30)
    .topSpaceToView(_partLine,23)
    .autoHeightRatio(0);
    
    _picContainerView.sd_layout
    .leftEqualToView(_contentLabel);
    
    _moreBtn.sd_layout
    .centerXEqualToView(_contentLabel)
    .topSpaceToView(_picContainerView,16)
    .widthIs(40)
    .heightIs(28);
    
}

-(void)setModel:(ProjectDetailLeftHeaderModel *)model
{
    _model = model;
    
    _shouldOpen = NO;
    
    _projectLabel.text = model.projectStr;
    [_projectLabel sizeToFit];
    
    _contentLabel.text = model.content;
    
    if (model.shouldShowMoreButton) {//如果文字超过三行
        if (model.isOpen) { //如果展开
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreBtn setImage:[UIImage imageNamed:@"收起"] forState:UIControlStateNormal];
        }else{
            _contentLabel.sd_layout.maxHeightIs(___maxContentLabelHeight);
            [_moreBtn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
        }
    }
    //默认显示一行数组
    NSMutableArray *picArray = [NSMutableArray array];
    if (!model.isOpen) {
        
        if (model.pictureArray.count > 3)
        {
            for (NSInteger i =0; i<3; i++)
            {
                [picArray addObject:model.pictureArray[i]];
            }
        }
        _picContainerView.pictureStringArray = picArray;
        
    }else{
        _picContainerView.pictureStringArray = model.pictureArray;
    }
    
    CGFloat picContainerTopMargin = 0;
    if (model.pictureArray.count) {
        picContainerTopMargin = 12;
    }
    
    _picContainerView.sd_layout
    .topSpaceToView(_contentLabel, picContainerTopMargin)
    .leftSpaceToView(self.contentView,15);
    
    [self setupAutoHeightWithBottomView:_moreBtn bottomMargin:15];
    
}
-(void)btnClick
{
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }
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
