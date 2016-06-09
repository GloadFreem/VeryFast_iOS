//
//  ProjectDetailSceneRightCell.m
//  JinZhiT
//
//  Created by Eugene on 16/5/13.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailSceneRightCell.h"

@implementation ProjectDetailSceneRightCell

- (void)awakeFromNib {
    // Initialization code
    
    _contentLabel.layer.cornerRadius = 3;
    _contentLabel.layer.masksToBounds = YES;
    
    _timeLabel.layer.cornerRadius = 2;
    _timeLabel.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
