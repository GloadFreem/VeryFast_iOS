//
//  ProjectPrepareFooterCommentView.h
//  company
//
//  Created by Eugene on 16/6/21.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectPrepareFooterCommentView : UIView


@property (nonatomic, strong) UIImageView *commentImage;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *commentNumber;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIImageView *moreImage;

@property (nonatomic, strong) UIView *firstLine;

@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) UIImageView *firstIcon;
@property (nonatomic, strong) UILabel *firstName;
@property (nonatomic, strong) UILabel *firstTime;
@property (nonatomic, strong) UILabel *firstContent;

@property (nonatomic, strong) UIView *secondView;
@property (nonatomic, strong) UIView *secondLine;
@property (nonatomic, strong) UIView *secondIcon;
@property (nonatomic, strong) UILabel *secondName;
@property (nonatomic, strong) UILabel *secondTime;
@property (nonatomic, strong) UILabel *secondContent;

@property (nonatomic, strong) UIButton *commentBtn;


@end
