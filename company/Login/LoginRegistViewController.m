//
//  LoginRegistViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/4.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "LoginRegistViewController.h"
#import "RegisterViewController.h"
#import "FindPassWordViewController.h"
#import "PerfectViewController.h"
#import "RenzhengViewController.h"
#define DENGLU @"loginUser"

@interface LoginRegistViewController ()
{
    UIActivityIndicatorView* activity;

    NSString *_password;
}

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *noBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
    
    NSString * string = [AES encrypt:DENGLU password:KEY];
    self.partner = [TDUtil encryptMD5String:string];
    //    NSLog(@"%@",_partner);
}

-(void)createUI{
    //头像
    _iconBtn.layer.cornerRadius = 52;
    _iconBtn.layer.masksToBounds = YES;
    _iconBtn.layer.borderWidth = 4;
    _iconBtn.layer.borderColor = color(190, 178, 176, 1).CGColor;
}
//登录
- (IBAction)loginClick:(UIButton *)sender {
    
    
    if ([sender isKindOfClass:[UIButton class]]) {
        //初始化网络请求对象
        //获取数据
        NSString *phoneNumber = self.phoneField.text;
        _password  = self.passwordField.text;
        
        //校验数据
        if (phoneNumber && ![phoneNumber isEqualToString:@""]) {
            if (![TDUtil validateMobile:phoneNumber]) {
                [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入正确手机号码"];
                self.phoneField.text=@"";
                return ;
            }
        }else{
            [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入手机号码"];
            return ;
        }
        
        if (!_password || [_password isEqualToString:@""]) {
            [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请输入密码"];
            return ;
        }
        
        //加密
        _password = [TDUtil encryptPhoneNumWithMD5:phoneNumber passString:_password];
        
        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:KEY,@"key",self.partner,@"partner",phoneNumber,@"telephone",_password,@"password",PLATFORM,@"platform", nil];
        
        //加载动画
        //加载动画控件
        if (!activity) {
            //进度
            activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(WIDTH(self.loginBtn)/3-18, HEIGHT(self.loginBtn)/2-15, 30, 30)];//指定进度轮的大小
            [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];//设置进度轮显示类型
            [self.loginBtn addSubview:activity];
        }else{
            if (!activity.isAnimating) {
                [activity startAnimating];
            }
        }
        [activity setColor:WriteColor];
        
        //开始加载动画
        [activity startAnimating];
        
        //开始请求
        [self.httpUtil getDataFromAPIWithOps:USER_LOGIN postParam:dic type:0 delegate:self sel:@selector(requestLogin:)];
    }
    

}

#pragma ASIHttpRequester
//===========================================================网络请求=====================================

/**
 *  登录
 *
 *  @param request 请求实例
 */
-(void)requestLogin:(ASIHTTPRequest *)request
{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
    NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    
    if (jsonDic!=nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        if ([status intValue] == 200) {
            NSLog(@"登陆成功");
            
            //进入主界面
            AppDelegate * app =(AppDelegate* )[[UIApplication sharedApplication] delegate];
            app.window.rootViewController = app.tabBar;
            //测试
//            PerfectViewController *per = [PerfectViewController new];
//            [self.navigationController pushViewController:per animated:YES];
           
            
            NSUserDefaults* data =[NSUserDefaults standardUserDefaults];
            [data setValue:self.phoneField.text forKey:STATIC_USER_DEFAULT_DISPATCH_PHONE];
            [data setValue:_password forKey:STATIC_USER_PASSWORD];
            [data setValue:@"YES" forKey:@"isLogin"];
            
//            [self removeFromParentViewController];
        }else{
            [[DialogUtil sharedInstance]showDlg:self.view textOnly:[jsonDic valueForKey:@"message"]];

        }
        
    }
    [activity stopAnimating];
}

/**
 *  网络请求失败
 *
 *  @param request 请求实例
 */
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
    NSLog(@"返回:%@",jsonString);
    self.startLoading =NO;
    [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"网络请求错误"];
    [activity stopAnimating];
    
}
//没有账号
- (IBAction)noBtn:(id)sender {
    
    RegisterViewController * registerVC = [RegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
//忘记密码
- (IBAction)forgetPassWord:(id)sender {
    FindPassWordViewController * find =[FindPassWordViewController new];
    [self.navigationController pushViewController:find animated:YES];
}
- (IBAction)weChatBtn:(UIButton *)sender {
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//让当前控制器对应的状态栏是白色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
