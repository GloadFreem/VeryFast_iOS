//
//  ProjectDetailFirstHeaderView.m
//  JinZhiT
//
//  Created by Eugene on 16/5/13.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailFirstHeaderView.h"

@implementation ProjectDetailFirstHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

#pragma mark -实例化视图
+(ProjectDetailFirstHeaderView*)instancetypeProjectDetailFirstHeaderView{
    //实例化视图
    ProjectDetailFirstHeaderView *view = [[[NSBundle mainBundle] loadNibNamed:@"ProjectDetailFirstHeaderView" owner:nil options:nil] lastObject];
    //创建scrollView
    [view createUI];
    //加载 数据
    [view refreshData];
    
    //计算视图高度，并赋给高度属性
    view.viewHeight = [view calculateViewHeight];
    
    return view;
}


#pragma mark- 创建布局
-(void)createUI
{
    //创建团队scrollView
    [self createScrollViewContent];
}

#pragma mark -团队scrollView添加控件
-(void)createScrollViewContent
{
    //根据模型来创建视图（scrollView、label）
    for (NSInteger i =0; i<4; i++) {
        UIButton * iconBtn =[[UIButton alloc]initWithFrame:CGRectMake(30+76*i, 22, 50, 50)];
        [iconBtn setTag:i+10];
        //btn加载图片
        
        
        
        //加到scrollView上边
        [_scrollView addSubview:iconBtn];
        //名字label
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30+76*i, 22+50+12, 50, 14)];
        nameLabel.textColor = [UIColor darkGrayColor];
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:nameLabel];
        //职位label
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(30+76*i, 22+50+12+6, 50, 12)];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
        [_scrollView addSubview:label];
    }

}
#pragma mark -刷新数据
-(void)refreshData
{
    
}

//计算View的高度
-(CGFloat)calculateViewHeight{
    return CGRectGetMaxY(_bottomView.frame);
}
@end
