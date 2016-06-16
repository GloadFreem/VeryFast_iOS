//
//  ProjectBannerModel.h
//  JinZhiT
//
//  Created by Eugene on 16/5/8.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectBannerModel : NSObject


@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *bannerType;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger bannerId;


@end
