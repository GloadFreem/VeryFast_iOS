//
//  InvestOrganizationSecondCell.h
//  JinZhiT
//
//  Created by Eugene on 16/5/17.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrganizationSecondModel.h"

@class InvestOrganizationSecondCell;

@protocol InvestOrganizationSecondCellDelegate <NSObject>

-(void)didClickCommitBtn:(InvestOrganizationSecondCell*)cell andModel:(OrganizationSecondModel*)model;

-(void)didClickAttentionBtn:(InvestOrganizationSecondCell*)cell andModel:(OrganizationSecondModel*)model;

@end


@interface InvestOrganizationSecondCell : UITableViewCell

@property (nonatomic, weak) id<InvestOrganizationSecondCellDelegate>delegate;

@property (nonatomic, strong) NSIndexPath *indexpath;

@property (nonatomic, strong) OrganizationSecondModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *address;


@property (weak, nonatomic) IBOutlet UILabel *firstLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;


@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelArray;






+ (instancetype)cellWithTableView:(UITableView *)tableView;




@end
