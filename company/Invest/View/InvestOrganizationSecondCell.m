//
//  InvestOrganizationSecondCell.m
//  JinZhiT
//
//  Created by Eugene on 16/5/17.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "InvestOrganizationSecondCell.h"

@implementation InvestOrganizationSecondCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"organizationSecond";
    InvestOrganizationSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _iconImage.layer.cornerRadius = 32.5;
    _iconImage.layer.masksToBounds = YES;
    
    _firstLabel.layer.cornerRadius = 3;
    _firstLabel.layer.masksToBounds = YES;
    _firstLabel.layer.borderColor = colorBlue.CGColor;
    _firstLabel.layer.borderWidth = 0.5;
    
    _secondLabel.layer.cornerRadius = 3;
    _secondLabel.layer.masksToBounds = YES;
    _secondLabel.layer.borderColor = colorBlue.CGColor;
    _secondLabel.layer.borderWidth = 0.5;
    
    _thirdLabel.layer.cornerRadius = 3;
    _thirdLabel.layer.masksToBounds = YES;
    _thirdLabel.layer.borderColor = colorBlue.CGColor;
    _thirdLabel.layer.borderWidth = 0.5;
    
    
}

-(void)setModel:(OrganizationSecondModel *)model
{
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headSculpture]] placeholderImage:[UIImage new]];
    _name.text = model.companyName;
    _address.text = model.companyAddress;
    //标题赋值
    for (NSInteger i = 0; i < model.areas.count; i ++) {
        UILabel *label = (UILabel*)_labelArray[i];
        label.text = model.areas[i];
    }
    [_attentionBtn setTitle:[NSString stringWithFormat:@" 关注(%ld)",model.collectCount] forState:UIControlStateNormal];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
