//
//  RegistNameTableViewCell.m
//  JinZhiT
//
//  Created by Eugene on 16/5/6.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "RegistNameTableViewCell.h"

@implementation RegistNameTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(CGFloat)getCellHeight
{
    return 8+8+_rightLabelHeight.constant;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
