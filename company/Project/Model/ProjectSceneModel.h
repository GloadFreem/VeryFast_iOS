//
//  ProjectSceneModel.h
//  company
//
//  Created by Eugene on 16/6/18.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Audiorecords,Scenecomments;
@interface ProjectSceneModel : NSObject


@property (nonatomic, assign) long long beginTime;

@property (nonatomic, assign) long long endTime;

@property (nonatomic, strong) NSArray<Scenecomments *> *scenecomments;

@property (nonatomic, strong) NSArray<Audiorecords *> *audiorecords;

@property (nonatomic, assign) NSInteger totlalTime;

@property (nonatomic, assign) NSInteger sceneId;

@property (nonatomic, copy) NSString *audioPath;



@end
@interface Audiorecords : NSObject

@property (nonatomic, assign) NSInteger playTime;

@property (nonatomic, assign) NSInteger playId;

@property (nonatomic, copy) NSString *imageUrl;

@end

@interface Scenecomments : NSObject

@property (nonatomic, assign) NSInteger commentId;

@property (nonatomic, copy) NSString *content;

@end

