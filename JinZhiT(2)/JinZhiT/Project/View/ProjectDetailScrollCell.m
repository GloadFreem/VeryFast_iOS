//
//  ProjectDetailScrollCell.m
//  JinZhiT
//
//  Created by Eugene on 16/5/10.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailScrollCell.h"

@implementation ProjectDetailScrollCell

- (void)awakeFromNib {
    // Initialization code
    [self setUp];
}

#pragma mark -初始化代码
-(void)setUp
{
    //设置scrollView的背景颜色
    _srollView.backgroundColor = [UIColor whiteColor];
    _modelArr = [NSArray array];
    //设置scrollView的内容大小
    _srollView.contentSize = CGSizeMake(30+76*self.modelArr.count, 0);
    
    _modelArr = [NSArray array];
    
//    //设置imageView 和 label的frame
//    for (NSInteger i=0; i<_modelArr.count; i++) {
//        UIImageView * imageView = [[UIImageView alloc]init];
//        imageView.image = [UIImage imageNamed:_modelArr[i]];
//        
//    }
    
}

#pragma mark -  setter方法的重写
-(void)setModelArr:(NSArray *)modelArr
{
    _modelArr = modelArr;
    //根据模型来创建视图（scrollView、label）
    for (NSInteger i =0; i<modelArr.count; i++) {
        UIButton * iconBtn =[[UIButton alloc]initWithFrame:CGRectMake(30+76*i, 22, 50, 50)];
        [iconBtn setTag:i+10];
        //btn加载图片
        
        //加到scrollView上边
        [_srollView addSubview:iconBtn];
        //名字label
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30+76*i, 22+50+12, 50, 14)];
        nameLabel.textColor = [UIColor darkGrayColor];
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [_srollView addSubview:nameLabel];
        //职位label
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(30+76*i, 22+50+12+6, 50, 12)];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
        [_srollView addSubview:label];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
