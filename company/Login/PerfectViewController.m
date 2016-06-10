//
//  PerfectViewController.m
//  JinZhiT
//
//  Created by Eugene on 16/5/5.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "PerfectViewController.h"
#import "RegistSuccessViewController.h"
#define IDENTIFYTYPE @"updateIdentiyTypeUser"
@interface PerfectViewController ()
{
    UIActivityIndicatorView *activity;
    UIImagePickerController *imagePicker;
}
@property (nonatomic, copy) NSString *identifyType;
@property (weak, nonatomic) IBOutlet UIButton *haveRegist;//完成注册按钮


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btn_Array;//身份按钮数组

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;//头像按钮
@property (nonatomic, strong) UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UILabel *identifyLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnTopSpace;

@property (weak, nonatomic) IBOutlet UIView *hiddenView;
@property (nonatomic, assign) BOOL isSelected;
@end

@implementation PerfectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
    NSString * string = [AES encrypt:IDENTIFYTYPE password:KEY];
    self.partner = [TDUtil encryptMD5String:string];
    //    NSLog(@"%@",_partner);
}

-(void)createUI{
    //选择头型按钮属性
    _iconBtn.layer.cornerRadius = 47.5;
    _iconBtn.layer.masksToBounds = YES;
    _iconBtn.layer.borderWidth = 4;
    _iconBtn.layer.borderColor = color(190, 178, 176, 1).CGColor;
    
    //完成注册按钮属性
    _haveRegist.layer.cornerRadius = 20;
    _haveRegist.layer.masksToBounds = YES;
    _haveRegist.layer.borderWidth = 1;
    _haveRegist.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    
    //身份按钮属性
    for (UIButton * btn in _btn_Array) {
        btn.layer.cornerRadius = 5;
        
    }
}
//返回
- (IBAction)leftBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//认证
- (IBAction)registSuccess:(id)sender {
    
    if (!_isSelected) {
        [[DialogUtil sharedInstance]showDlg:self.view textOnly:@"请选择身份"];
        return;
    }
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:KEY,@"key",self.partner,@"partner",self.identifyType,@"ideniyType",@"0",@"isWebchatLogin", nil];
    UIImage *iconImage = self.iconBtn.currentBackgroundImage;
    //压缩图片
    iconImage = [TDUtil drawInRectImage:iconImage size:CGSizeMake(300, 300)];
    //保存图片
    [TDUtil saveContent:iconImage fileName:@"iconImage"];
    //上传图片字典
    NSDictionary *picDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"iconImage",@"file", nil];
    //加载动画
    //加载动画控件
    if (!activity) {
        //进度
        activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(WIDTH(self.haveRegist)/3-18, HEIGHT(self.haveRegist)/2-15, 30, 30)];//指定进度轮的大小
        [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];//设置进度轮显示类型
        [self.haveRegist addSubview:activity];
    }else{
        if (!activity.isAnimating) {
            [activity startAnimating];
        }
    }
    [activity setColor:WriteColor];
    
    //开始加载动画
    [activity startAnimating];
    
    [self.httpUtil getDataFromAPIWithOps:USER_IDENTIFY_TYPE postParam:dic files:picDic type:0 delegate:self sel:@selector(requestSetIdentifyType:)];

//    RegistSuccessViewController * regist = [RegistSuccessViewController new];
//    regist.identify = _identifyType;
//    [self.navigationController pushViewController:regist animated:YES];
}
//注册身份
-(void)requestSetIdentifyType:(ASIHTTPRequest *)request
{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
    NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    
    if (jsonDic!=nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        
        if ([status integerValue] == 200) {
            
            //进入注册成功界面
            RegistSuccessViewController * regist = [RegistSuccessViewController new];
            regist.identify = _identifyType;
            NSDictionary *data = [jsonDic valueForKey:@"data"];
            regist.inviteCode = [data valueForKey:@"inviteCode"];
            NSLog(@"获取指环码%@",regist.inviteCode);
            
            [self.navigationController pushViewController:regist animated:YES
             ];
            
        }else{
            [[DialogUtil sharedInstance]showDlg:self.view textOnly:[jsonDic valueForKey:@"message"]];
            
        }
    }
    [activity stopAnimating];
    
    //测试
    
//    //进入注册成功界面
//    RegistSuccessViewController * regist = [RegistSuccessViewController new];
//    regist.identify = _identifyType;
//    [self.navigationController pushViewController:regist animated:YES];
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    [activity stopAnimating];
}
//选择身份
- (IBAction)chooseIdentity:(UIButton *)sender {
    
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _hiddenView.hidden = NO;
        _identifyLabel.hidden = YES;
        _topSpace.constant = 122;
        _btnTopSpace.constant = 40;
        _isSelected  = YES;
    }else{
        _hiddenView.hidden = YES;
        _identifyLabel.hidden = NO;
        _topSpace.constant = 92;
        _btnTopSpace.constant = 76;
        _isSelected = NO;
    }
    for (UIButton *btn in _btn_Array) {
        if (btn.tag != sender.tag) {
            btn.selected = NO;
        }
        if (!btn.selected) {
            [btn setBackgroundColor:[UIColor blackColor]];
            btn.alpha = 0.5;
            
        }else{
            [btn setBackgroundColor:color(253, 104, 2, 1)];
            btn.alpha = 1;
            
        }
        
    }
    
    self.identifyType = [NSString stringWithFormat:@"%ld",sender.tag];
}

- (IBAction)iconBtnClick:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    __block PerfectViewController* blockSelf = self;
    // Create the actions.
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [blockSelf takePhoto];
    }];
    
    UIAlertAction *chooiceAction = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [blockSelf pickImageFromAlbum];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    // Add the actions.
    [alertController addAction:takePhotoAction];
    [alertController addAction:chooiceAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}
//从相册选择
-(void)pickImageFromAlbum
{
    imagePicker = [[UIImagePickerController alloc]init];
    //从相片库中加载图片
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    [imagePicker setDelegate:self];
    //允许编辑
    [imagePicker setAllowsEditing:YES];
    
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
    
}

//拍照
-(void)takePhoto
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
}

#pragma mark - UIImagePickerControllerDelegate
//得到照片后，调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * image=[info objectForKey:UIImagePickerControllerEditedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.iconBtn setBackgroundImage:image forState:UIControlStateNormal];
    
}

//点击cancle
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
