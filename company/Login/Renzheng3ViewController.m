//
//  Renzheng3ViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/6.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "Renzheng3ViewController.h"
#import "Renzheng4ViewController.h"
#import "Renzheng2ViewController.h"
@interface Renzheng3ViewController ()<UITextViewDelegate>



@property (weak, nonatomic) IBOutlet UITextView *firstTextView;
@property (weak, nonatomic) IBOutlet UITextView *secondTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstTextHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondTextHeight;


@end

@implementation Renzheng3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
}
#pragma mark- 改变button布局
-(void)createUI
{
    _nextBtn.layer.cornerRadius = 20;
    _nextBtn.layer.masksToBounds = YES;
    
}
- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextStupClick:(UIButton *)sender {
    Renzheng4ViewController * regist =[Renzheng4ViewController new];
    [self.navigationController pushViewController:regist animated:YES];
}

#pragma mark- textView  delegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 0) {
        textView.text = @"";
    }else{
        textView.text = @"";
    }
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.tag == 0 && ![textView.text isEqualToString:@"写一写公司介绍"]) {
        CGFloat height = [self heightForString:textView andWidth:textView.frame.size.width];
        if (height > _firstTextHeight.constant) {
            _firstTextHeight.constant = height;
        }
    }else if (textView.tag == 1 &&![textView.text isEqualToString:@"写一写个人介绍"]){
        CGFloat height = [self heightForString:textView andWidth:textView.frame.size.width];
        if (height > _secondTextHeight.constant) {
            _secondTextHeight.constant = height;
        }
    }
}


-(void)textViewDidEndEditing:(UITextView *)textView
{
    
}

#pragma mark -计算textView的高度
-(CGFloat)heightForString:(UITextView*)textView andWidth:(CGFloat)width
{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

//让当前控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
