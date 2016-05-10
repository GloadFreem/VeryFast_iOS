//
//  RegistSuccessViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/5.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "RegistSuccessViewController.h"
#import "RenzhengViewController.h"
@interface RegistSuccessViewController ()
@property (weak, nonatomic) IBOutlet UIButton *shiyongBtn;

@end

@implementation RegistSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
}


-(void)createUI{
    _shiyongBtn.layer.cornerRadius = 20;
    _shiyongBtn.layer.masksToBounds = YES;
    _shiyongBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    _shiyongBtn.layer.borderWidth = 1;
}
- (IBAction)clickBtn:(UIButton*)sender {
    if (sender.tag == 1) {
        RenzhengViewController  * renzheng = [RenzhengViewController new];
        [self.navigationController pushViewController:renzheng animated:YES];
    }
    
}

@end
