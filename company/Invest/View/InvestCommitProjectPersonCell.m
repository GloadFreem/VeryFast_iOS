//
//  InvestCommitProjectPersonCell.m
//  JinZhiT
//
//  Created by Eugene on 16/5/27.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "InvestCommitProjectPersonCell.h"

@implementation InvestCommitProjectPersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _iconImage.layer.cornerRadius = 29;
    _iconImage.layer.masksToBounds = YES;
    
}


-(void)setModel:(InvestListModel *)model
{
    _model = model;
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headSculpture]] placeholderImage:[UIImage new]];
    _nameLabel.text = model.name;
    _positionLabel.text = model.position;
    _companyLabel.text = model.companyName;
    _addressLabel.text = model.companyAddress;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
