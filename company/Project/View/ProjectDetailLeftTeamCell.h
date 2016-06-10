//
//  ProjectDetailLeftTeamCell.h
//  JinZhiT
//
//  Created by Eugene on 16/6/1.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectDetailLeftTeamModel.h"

@interface ProjectDetailLeftTeamCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong) ProjectDetailLeftTeamModel *model;
@property (nonatomic, strong) NSArray *modelArray;

@end
