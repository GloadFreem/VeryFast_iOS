//
//  ProjectListCell.m
//  JinZhiT
//
//  Created by Eugene on 16/5/8.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectListCell.h"

@implementation ProjectListCell

- (void)awakeFromNib {
    // Initialization codeor
    _iconImage.layer.cornerRadius = 30;
    _iconImage.layer.masksToBounds = YES;
    
    _leftLabel.layer.cornerRadius = 3;
    _leftLabel.layer.masksToBounds = YES;
    _leftLabel.layer.borderWidth = 0.5;
    _leftLabel.layer.borderColor = colorBlue.CGColor;
    
    _middleLabel.layer.cornerRadius = 3;
    _middleLabel.layer.masksToBounds = YES;
    _middleLabel.layer.borderWidth = 0.5;
    _middleLabel.layer.borderColor = colorBlue.CGColor;
    _rightLabel.layer.cornerRadius = 3;
    _rightLabel.layer.masksToBounds = YES;
    _rightLabel.layer.borderWidth = 0.5;
    _rightLabel.layer.borderColor = colorBlue.CGColor;
}

-(void)setModel:(ProjectListProModel *)model
{
    _model = model;
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.startPageImage]] placeholderImage:[UIImage new]];
    
    //根据状态判断 状态图片
    if (!model.status) {
        _iconImage.hidden = YES;
    }
    if ([model.status isEqualToString:@"待路演"]) {
        _iconImage.image = [UIImage imageNamed:@"invest_noroad"];
    }
    if ([model.status isEqualToString:@"路演中"]) {
        _iconImage.image = [UIImage imageNamed:@"invest_roading"];
    }
    if ([model.status isEqualToString:@"预选"]) {
        _iconImage.image = [UIImage imageNamed:@"invest_yuxuan"];
    }
    
    //隐藏多余的 label
    for (NSInteger i =model.areas.count; i < _labelArray.count; i ++) {
        UILabel *label = (UILabel *)_labelArray[i];
        label.hidden = YES;
    }
    //赋值
    for (NSInteger i =0; i < model.areas.count; i ++) {
        UILabel *label = (UILabel *)_labelArray[i];
        label.text = model.areas[i];
    }
    
    _projectLabel.text = model.abbrevName;
    _addressLabel.text = model.address;
    _companyLabel.text = model.fullName;
    _personNumLabel.text = [NSString stringWithFormat:@"%ld",model.collectionCount];
    _moneyLabel.text = [NSString stringWithFormat:@"%ld",model.financeTotal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
