//
//  CircleForwardVC.m
//  JinZhiT
//
//  Created by Eugene on 16/5/27.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "CircleForwardVC.h"
#define kTextContent @"说说吧···"
@interface CircleForwardVC ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation CircleForwardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    UIButton *forwardBtn = [UIButton new];
    [forwardBtn setBackgroundColor:[UIColor clearColor]];
    
    forwardBtn.tag = 1;
    [forwardBtn setTitle:@"转发" forState:UIControlStateNormal];
    forwardBtn.titleLabel.font = BGFont(13);
    [forwardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forwardBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    forwardBtn.layer.cornerRadius =3;
    forwardBtn.layer.masksToBounds = YES;
    forwardBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    forwardBtn.layer.borderWidth = 0.5;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:forwardBtn];
    
    self.navigationItem.title = @"转发";
}


-(void)createUI
{
    self.view.backgroundColor = colorGray;
    //输入框
    _textView = [UITextView new];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.delegate = self;
    _textView.text = kTextContent;
    _textView.font = BGFont(14);
    _textView.textColor = color74;
    _textView.returnKeyType = UIReturnKeyDefault;
    _textView.keyboardType = UIKeyboardTypeDefault;
    _textView.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_textView];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(120*HEIGHTCONFIG);
    }];
    //转发内容容器
    _containerView = [UIView new];
    [_containerView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_containerView];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(_textView.mas_bottom).offset(10*HEIGHTCONFIG);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(60*HEIGHTCONFIG);
    }];
    //头像
    _iconImage = [UIImageView new];
    _iconImage.layer.cornerRadius = 20;
    _iconImage.layer.masksToBounds = YES;
    [_containerView addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_containerView.mas_left).offset(12*WIDTHCONFIG);
        make.top.mas_equalTo(_containerView.mas_top).offset(10*HEIGHTCONFIG);
        make.width.height.mas_equalTo(40*WIDTHCONFIG);
    }];
    //标题
    _titleLabel = [UILabel new];
    _titleLabel.font = BGFont(15);
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [_containerView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImage.mas_right).offset(5*WIDTHCONFIG);
        make.top.mas_equalTo(_containerView.mas_top).offset(9*HEIGHTCONFIG);
        make.height.mas_equalTo(15*HEIGHTCONFIG);
    }];
    //内容
    _contentLabel = [UILabel new];
    _contentLabel.font = BGFont(13);
    _contentLabel.textColor = color47;
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    [_containerView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.top.mas_equalTo(_titleLabel.mas_bottom).offset(7*HEIGHTCONFIG);
        make.height.mas_equalTo(13*HEIGHTCONFIG);
        make.right.mas_equalTo(_containerView.mas_right).offset(-12*WIDTHCONFIG);
    }];
    
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
    _textView.font= BGFont(16);
    textView.text = @"";
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        _textView.font = BGFont(14);
        _textView.text = kTextContent;
    }
    
}

-(void)btnClick:(UIButton*)btn
{
    if (btn.tag == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (btn.tag == 1) {
        NSLog(@"点击转发按钮");
    }
}
@end
