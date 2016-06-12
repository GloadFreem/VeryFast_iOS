//
//  CircleDetailHeaderCell.h
//  company
//
//  Created by Eugene on 16/6/12.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CircleDetailHeaderCell;
@class CircleListModel;

@protocol CircleDetailHeaderCellDelegate <NSObject>

-(void)didClickPraiseBtn:(CircleDetailHeaderCell*)cell model:(CircleListModel*)model;

@end

@interface CircleDetailHeaderCell : UITableViewCell

@property (nonatomic, weak) id<CircleDetailHeaderCellDelegate>delegate;

@property (nonatomic, strong) CircleListModel *model;
@property (nonatomic, strong) UIButton *praiseBtn;

@end
