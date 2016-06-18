//
//  ProjectDetailLeftTeamCell.h
//  JinZhiT
//
//  Created by Eugene on 16/6/1.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectDetailLeftTeamModel.h"
#import "ProjectDetailBaseMOdel.h"
@interface ProjectDetailLeftTeamCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong) DetailTeams *model;
@property (nonatomic, strong) NSArray *modelArray;

@end
