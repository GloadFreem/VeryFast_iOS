//
//  ProjectDetailBottomContainerCell.m
//  JinZhiT
//
//  Created by Eugene on 16/5/12.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailBottomContainerCell.h"
#import "SegmentView.h"
#import "MeasureTool.h"
@implementation ProjectDetailBottomContainerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark -  创建cell内部布局
-(void)createUI
{
    _titleArray = @[@"详情",@"成员",@"现场"];
    
    //布局
    SegmentView * segmentView =[[SegmentView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 0.75*SCREENWIDTH) titleArray:_titleArray selectType:0];
    segmentView.lineColor = [UIColor orangeColor];
    [self.contentView addSubview:segmentView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
