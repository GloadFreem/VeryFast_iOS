//
//  ResetPassWordViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/5.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ResetPassWordViewController.h"

@interface ResetPassWordViewController ()

@property (weak, nonatomic) IBOutlet UIButton *certainBtn;
@end

@implementation ResetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
}

-(void)createUI{
    _certainBtn.layer.cornerRadius = 20;
    _certainBtn.layer.masksToBounds = YES;
    _certainBtn.layer.borderWidth = 1;
    _certainBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
}
- (IBAction)leftBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
