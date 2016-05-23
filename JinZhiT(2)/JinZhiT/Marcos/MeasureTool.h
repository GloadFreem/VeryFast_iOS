
//
//  MeasureTool.h
//  JinZhiT
//
//  Created by Eugene on 16/5/3.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#ifndef MeasureTool_h
#define MeasureTool_h

#define SCREENWIDTH [UIScreen mainScreen] .bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen] .bounds.size.height
#define WIDTHCONFIG ([[UIScreen mainScreen] bounds].size.width/375.0)
#define HEIGHTCONFIG ([[UIScreen mainScreen] bounds].size.height/667.0)
#define color(r,g,b,al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]

#define BGFont(size) [UIFont systemFontOfSize:size]

#endif /* MeasureTool_h */
