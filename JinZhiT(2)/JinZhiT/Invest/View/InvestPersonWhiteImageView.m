//
//  InvestPersonWhiteImageView.m
//  JinZhiT
//
//  Created by Eugene on 16/5/18.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "InvestPersonWhiteImageView.h"

@implementation InvestPersonWhiteImageView


#pragma mark- 实例化视图
+(InvestPersonWhiteImageView*)instancetationInvestPersonWhiteImageView
{
    InvestPersonWhiteImageView *view =[[[NSBundle mainBundle] loadNibNamed:@"InvestPersonWhiteImageView" owner:nil options:nil] lastObject];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
