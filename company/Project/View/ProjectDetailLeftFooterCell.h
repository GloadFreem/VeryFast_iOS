//
//  ProjectDetailLeftFooterCell.h
//  JinZhiT
//
//  Created by Eugene on 16/6/1.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectDetailLeftFooterModel.h"

#import "ProjectDetailBaseMOdel.h"

@interface ProjectDetailLeftFooterCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong) DetailExtr *model;

@property (nonatomic, strong) NSArray *modelArray;

@end
