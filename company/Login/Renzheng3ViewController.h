//
//  Renzheng3ViewController.h
//  JinZhiT
//
//  Created by Eugene on 16/5/6.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Renzheng3ViewController : RootViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel; //标题label

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (nonatomic, strong) NSMutableDictionary *dicData;

@property (nonatomic, copy) NSString *identifyType;

@end
