//
//  ActivityBlackCoverView.m
//  company
//
//  Created by Eugene on 16/6/16.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ActivityBlackCoverView.h"

@implementation ActivityBlackCoverView

#pragma mark- 实例化视图
+(ActivityBlackCoverView*)instancetationActivityBlackCoverView
{
    ActivityBlackCoverView *view =[[[NSBundle mainBundle] loadNibNamed:@"ActivityBlackCoverView" owner:nil options:nil] lastObject];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void)awakeFromNib
{
    _cancleBtn.layer.cornerRadius = 5;
    _cancleBtn.layer.masksToBounds = YES;
    _certainBtn.layer.cornerRadius = 5;
    _certainBtn.layer.masksToBounds = YES;
}
- (IBAction)btnClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickBtnInView:andIndex:)]) {
        [self.delegate clickBtnInView:self andIndex:sender.tag];
    }
}


@end
