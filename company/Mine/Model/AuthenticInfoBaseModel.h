//
//  AuthenticInfoBaseModel.h
//  company
//
//  Created by Eugene on 16/6/13.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthenticIndustorytypeModel : NSObject

@property (nonatomic, assign) NSInteger industoryId;
@property (nonatomic, copy) NSString *name;

@end

@interface AuthenticIndustoryareaModel : NSObject

@property (nonatomic, assign) NSInteger areaId;
@property (nonatomic, assign) BOOL isvalid;
@property (nonatomic, copy) NSString *name;

@end

@interface AuthenticIdentiytypeModel : NSObject

@property (nonatomic, assign) NSInteger identiyTypeId;
@property (nonatomic, copy) NSString *name;
@end

@interface AuthenticProvinceModel : NSObject

@property (nonatomic, assign) BOOL isInvlid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger provinceId;

@end

@interface AuthenticCityModel : NSObject

@property (nonatomic, assign) NSInteger cityId;
@property (nonatomic, assign) BOOL isInvlid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) AuthenticProvinceModel *province;

@end

@interface AuthenticStatusModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger statusId;

@end


@interface AuthenticInfoBaseModel : NSObject

@property (nonatomic, strong) AuthenticStatusModel *authenticstatus;
@property (nonatomic, assign) NSInteger authId;
@property (nonatomic, copy) NSString *buinessLicence;
@property (nonatomic, copy) NSString *buinessLicenceNo;
@property (nonatomic, strong) AuthenticCityModel *city;
@property (nonatomic, copy) NSString *companyAddress;
@property (nonatomic, copy) NSString *companyIntroduce;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *identiyCarA;
@property (nonatomic, copy) NSString *identiyCarB;
@property (nonatomic, copy) NSString *identiyCarNo;
@property (nonatomic, strong) AuthenticIdentiytypeModel *identiytype;
@property (nonatomic, strong) AuthenticIndustoryareaModel *industoryarea;
@property (nonatomic, strong) AuthenticIndustorytypeModel *industorytype;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *optional;
@property (nonatomic, copy) NSString *position;


@end
