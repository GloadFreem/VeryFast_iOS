//
//  ActivityDetailHeaderModel.h
//  JinZhiT
//
//  Created by Eugene on 16/5/20.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface ActivityDetailHeaderModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray *pictureArray;    //



@property (nonatomic, assign) BOOL isOpen;

@property (nonatomic, assign) BOOL shouldShowMoreButton;

@end