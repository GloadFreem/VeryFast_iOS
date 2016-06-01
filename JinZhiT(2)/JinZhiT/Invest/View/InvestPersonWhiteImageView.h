//
//  InvestPersonWhiteImageView.h
//  JinZhiT
//
//  Created by Eugene on 16/5/18.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestPersonWhiteImageView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@property (weak, nonatomic) IBOutlet UIButton *middleBtn;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

#pragma mark- 实例化视图
+(InvestPersonWhiteImageView*)instancetationInvestPersonWhiteImageView;

@end
