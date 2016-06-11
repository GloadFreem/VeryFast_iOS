//
//  CircleListModel.h
//  JinZhiT
//
//  Created by Eugene on 16/5/26.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>








@interface CircleListModel : NSObject






@property (nonatomic, copy) NSString *iconNameStr;
@property (nonatomic, copy) NSString *nameStr;  //
@property (nonatomic, copy) NSString *addressStr;  //
@property (nonatomic, copy) NSString *companyStr;  //
@property (nonatomic, copy) NSString *positionStr;  //
@property (nonatomic, copy) NSString *timeSTr;  //
@property (nonatomic, copy) NSString *msgContent;  //
@property (nonatomic, assign) NSInteger publicContentId; //帖子id

@property (nonatomic, assign, getter = isLiked) BOOL liked;

@property (nonatomic, strong) NSArray *picNamesArray;    //
@property (nonatomic, assign) BOOL isOpening;
@property (nonatomic, assign ,readonly) BOOL shouldShowMoreBtn;


@end
