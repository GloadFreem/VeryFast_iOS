//
//  ProjectDetailMemberView.m
//  JinZhiT
//
//  Created by Eugene on 16/5/13.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailMemberView.h"

@implementation ProjectDetailMemberView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
    }
    return self;
}


#pragma mark- 实例化视图
+(ProjectDetailMemberView*)instancetationProjectDetailMemberView
{
    ProjectDetailMemberView *view =[[[NSBundle mainBundle] loadNibNamed:@"ProjectDetailMemberView" owner:nil options:nil] lastObject];
    //加载数据
    [view refreshData];
    //计算View的高度
    view.viewHeight = [view calculateViewHeight];
    
    return view;
}

#pragma mark -加载数据
-(void)refreshData
{
    
}

#pragma mark -计算高度
-(CGFloat)calculateViewHeight{
    return CGRectGetMaxY(_emailLabel.frame)+30;
}
@end
