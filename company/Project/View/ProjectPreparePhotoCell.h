//
//  ProjectPreparePhotoCell.h
//  company
//
//  Created by Eugene on 16/6/17.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectDetailLeftHeaderModel.h"
@interface ProjectPreparePhotoCell : UITableViewCell

@property (nonatomic, strong) ProjectDetailLeftHeaderModel *model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@end
