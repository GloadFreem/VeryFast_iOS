//
//  ActivityDetailCommentView.m
//  JinZhiT
//
//  Created by Eugene on 16/5/21.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ActivityDetailCommentView.h"

#import "ActivityDetailCommentCellModel.h"
#import "MLLinkLabel.h"

@interface ActivityDetailCommentView ()

@property (nonatomic, strong) NSArray *likeItemsArray;
@property (nonatomic, strong) NSArray *commentItemsArray;

@property (nonatomic, strong) MLLinkLabel *likeLabel;
@property (nonatomic, strong) UIView *likeLabelBottomLine;

@property (nonatomic, strong) NSMutableArray *commentLabelsArray;


@end

@implementation ActivityDetailCommentView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}


-(void)setupViews
{
    
}

-(void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray
{
    
}
@end
