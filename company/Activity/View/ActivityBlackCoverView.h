//
//  ActivityBlackCoverView.h
//  company
//
//  Created by Eugene on 16/6/16.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActivityBlackCoverView;

@protocol ActivityBlackCoverViewDelegate <NSObject>

-(void)clickBtnInView:(ActivityBlackCoverView*)view andIndex:(NSInteger)index;

@end

@interface ActivityBlackCoverView : UIView

@property (nonatomic, weak) id<ActivityBlackCoverViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UITextView *textView;


@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;

@property (weak, nonatomic) IBOutlet UIButton *certainBtn;

+(ActivityBlackCoverView*)instancetationActivityBlackCoverView;

@end
