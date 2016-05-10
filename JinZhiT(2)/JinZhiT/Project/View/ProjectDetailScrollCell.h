//
//  ProjectDetailScrollCell.h
//  JinZhiT
//
//  Created by Eugene on 16/5/10.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectDetailScrollCell : UITableViewCell<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *srollView;

@property (nonatomic, strong) NSArray * modelArr;

-(void)relayoutModelArr:(NSArray*)arr;


-(CGFloat)getCellHeight;

@end
