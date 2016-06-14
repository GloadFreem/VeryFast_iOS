//
//  InvestOrganizationSecondCell.h
//  JinZhiT
//
//  Created by Eugene on 16/5/17.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrganizationSecondModel.h"

@interface InvestOrganizationSecondCell : UITableViewCell

@property (nonatomic, strong) OrganizationSecondModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *address;


@property (weak, nonatomic) IBOutlet UILabel *firstLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;


@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelArray;






+ (instancetype)cellWithTableView:(UITableView *)tableView;




@end
