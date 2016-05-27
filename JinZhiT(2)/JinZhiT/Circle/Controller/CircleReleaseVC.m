//
//  CircleReleaseVC.m
//  JinZhiT
//
//  Created by Eugene on 16/5/26.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "CircleReleaseVC.h"
#define textViewContent @"发布最新、最热、最前沿的投融资话题"
@interface CircleReleaseVC ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderlabel;    //
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CircleReleaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = colorGray;
    
    [self setupNav];
    
    [self createUI];
}

#pragma mark -设置导航栏
-(void)setupNav
{
    UIButton * leftback = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftback setBackgroundImage:[UIImage imageNamed:@"leftBack"] forState:UIControlStateNormal];
    leftback.tag = 0;
    leftback.size = leftback.currentBackgroundImage.size;
    [leftback addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftback] ;
    
    UIButton *releaseBtn = [UIButton new];
    [releaseBtn setBackgroundImage:[UIImage imageNamed:@"icon_releaseBtn"] forState:UIControlStateNormal];
    releaseBtn.tag = 1;
    releaseBtn.size = releaseBtn.currentBackgroundImage.size;
    [releaseBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:releaseBtn];
    
    self.navigationItem.title = @"发布话题";
}

#pragma mark -初始化内容
-(void)createUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(230*HEIGHTCONFIG);
    }];
    
    _textView = [UITextView new];
    _textView.delegate = self;
    _textView.font = BGFont(15);
    _textView.textColor = color47;
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.returnKeyType = UIReturnKeyDefault;
    _textView.keyboardType = UIKeyboardTypeDefault;
    _textView.text = textViewContent;
    _textView.scrollEnabled = YES;
    [backView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView.mas_left).offset(20*WIDTHCONFIG);
        make.top.mas_equalTo(backView.mas_top).offset(13*HEIGHTCONFIG);
        make.right.mas_equalTo(backView.mas_right).offset(-20*WIDTHCONFIG);
        make.height.mas_equalTo(200*HEIGHTCONFIG);
    }];
    
    _imageView = [UIImageView new];
}

#pragma mark -textViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _textView.font= BGFont(18);
    textView.text = @"";
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        _textView.font = BGFont(15);
        _textView.text = textViewContent;
    }
    
}
-(void)btnClick:(UIButton*)btn
{
    if (btn.tag == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
