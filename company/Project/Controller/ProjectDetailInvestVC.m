//
//  ProjectDetailInvestVC.m
//  JinZhiT
//
//  Created by Eugene on 16/6/2.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailInvestVC.h"

@interface ProjectDetailInvestVC ()<UITextFieldDelegate>
{
    UITextField *_textField;
    UIView *_btnView;
    UIButton *_firstBtn;
    UIButton *_secondBtn;
    UIButton *_payBtn;
    UILabel *_textLabel;
    NSMutableArray *_titleArray;
    NSMutableArray *_flagArray;
    NSInteger _flag;
}
@end

@implementation ProjectDetailInvestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _flag = 0;
    [self setNav];
    [self setup];
}

-(void)setNav
{
    self.navigationItem.title = @"认投项目";
    UIButton * leftback = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftback setImage:[UIImage imageNamed:@"leftBack"] forState:UIControlStateNormal];
    [leftback addTarget:self action:@selector(leftback) forControlEvents:UIControlEventTouchUpInside];
    leftback.size = CGSizeMake(32, 18);
    [leftback addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftback];
}
-(void)setup
{
    UILabel *remindLabel = [UILabel new];
    remindLabel.text = @"请输入认投金额";
    remindLabel.textColor = [UIColor blackColor];
    remindLabel.font = BGFont(16);
    remindLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:remindLabel];
    remindLabel.sd_layout
    .leftSpaceToView(self.view, 24)
    .topSpaceToView(self.view, 29)
    .heightIs(16);
    [remindLabel setSingleLineAutoResizeWithMaxWidth:180];
    
    _textField = [UITextField new];
    _textField.delegate = self;
    _textField.font = BGFont(16);
    _textField.textAlignment = NSTextAlignmentLeft;
    _textField.placeholder = @"最小单位为 （万）";
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.borderStyle = UITextBorderStyleBezel;
    
    UILabel *rightLabel = [UILabel new];
    rightLabel.text = @"万";
    rightLabel.textColor = orangeColor;
    rightLabel.font = BGFont(16);
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.frame = CGRectMake(0, 0, 18, 18);
    _textField.rightView = rightLabel;
    _textField.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_textField];
    _textField.sd_layout
    .leftSpaceToView(self.view, 24)
    .topSpaceToView(remindLabel, 9)
    .heightIs(44)
    .rightSpaceToView(self.view, 72);
    
    _btnView = [UIView new];
    _btnView.backgroundColor = orangeColor;
    [self.view addSubview:_btnView];
    _btnView.sd_layout
    .leftSpaceToView(_textField,0)
    .topSpaceToView(remindLabel,9)
    .widthIs(48)
    .heightIs(44);
    
    
    _titleArray = [NSMutableArray arrayWithObjects:@"领投",@"跟投", nil];
    _flagArray = [NSMutableArray arrayWithObjects:@"0",@"1", nil];
    _firstBtn = [UIButton new];
    _firstBtn.backgroundColor = orangeColor;
    _firstBtn.tag = 0;
    [_firstBtn setTitle:_titleArray[0] forState:UIControlStateNormal];
    _firstBtn.titleLabel.font = BGFont(15);
    [_firstBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_firstBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btnView addSubview:_firstBtn];
    _firstBtn.sd_layout
    .leftEqualToView(_btnView)
    .topEqualToView(_btnView)
    .heightIs(44)
    .widthIs(48);
    
    _secondBtn = [UIButton new];
    _secondBtn.tag = 1;
    _secondBtn.backgroundColor = orangeColor;
    [_secondBtn setTitle:_titleArray[1] forState:UIControlStateNormal];
    _secondBtn.titleLabel.font = BGFont(15);
    [_secondBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //默认不显示
    [_secondBtn setHidden:YES];
    [_btnView addSubview:_secondBtn];
    _secondBtn.sd_layout
    .leftEqualToView(_firstBtn)
    .topSpaceToView(_firstBtn,0)
    .widthIs(48)
    .heightIs(44);
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:@"温馨提示：\n1、此处领投，跟投仅为用户意向，待项目达成后项目方会协同各方确定最为合适的领投方；\n2、特别注意：投资金额后面的单位为“万”"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:13];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    
    _textLabel = [UILabel new];
    _textLabel.font = BGFont(12);
    _textLabel.textAlignment = NSTextAlignmentLeft;
    _textLabel.textColor = color74;
    _textLabel.attributedText = attributedString;
    [self.view addSubview:_textLabel];
    _textLabel.sd_layout
    .leftEqualToView(_textField)
    .rightEqualToView(_btnView)
    .topSpaceToView(_textField, 33)
    .autoHeightRatio(0);
    
    _textLabel.isAttributedContent = YES;
    
    _payBtn = [UIButton new];
    [_payBtn setTag:5];
    [_payBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_payBtn setBackgroundColor:orangeColor];
    [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _payBtn.titleLabel.font = BGFont(16);
    _payBtn.layer.cornerRadius = 5;
    _payBtn.layer.masksToBounds = YES;
    [self.view addSubview:_payBtn];
    _payBtn.sd_layout
    .centerXEqualToView(self.view)
    .bottomSpaceToView(self.view, 67)
    .widthIs(300)
    .heightIs(44);
}

#pragma mark -textFieldDelegate



-(void)leftback
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)btnClick:(UIButton*)btn
{
    if (btn.tag == 0) {
        _secondBtn.hidden = _secondBtn.hidden;
        
    }
    
    if (btn.tag == 1) {
        NSString *title = _titleArray[0];
        _titleArray[0] = _titleArray[1];
        _titleArray[1] = title;
        NSString *flag = _flagArray[0];
        _flagArray[0] = _flagArray[1];
        _flagArray[1] = flag;
        
        [_firstBtn setTitle:_titleArray[0] forState:UIControlStateNormal];
        [_secondBtn setTitle:_titleArray[1] forState:UIControlStateNormal];
        
        
        _secondBtn.hidden = YES;
        
    }
    
    
    
    if (btn.tag == 5) {
        NSLog(@"立即支付");
    }
    
    btn.selected = !btn.selected;
    
}
@end
