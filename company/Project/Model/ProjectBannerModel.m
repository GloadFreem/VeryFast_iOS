//
//  ProjectBannerModel.m
//  JinZhiT
//
//  Created by Eugene on 16/5/8.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectBannerModel.h"

@implementation ProjectBannerModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"desc" : @"description"
             };
}

@end
