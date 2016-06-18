//
//  ProjectDetailMemberView.m
//  JinZhiT
//
//  Created by Eugene on 16/5/13.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailMemberView.h"
#define REQUESTMEMBER @"requestProjectMember"

@implementation ProjectDetailMemberView
{
   NSString *_memberPartner; 
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
    }
    return self;
}


#pragma mark- 实例化视图
+(ProjectDetailMemberView*)instancetationProjectDetailMemberView
{
    ProjectDetailMemberView *view =[[[NSBundle mainBundle] loadNibNamed:@"ProjectDetailMemberView" owner:nil options:nil] lastObject];
   view.autoresizingMask = UIViewAutoresizingNone;
    return view;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ([super initWithCoder:aDecoder]) {
        
        
        
        //计算View的高度
        
        self.viewHeight = 350;
        self.width = SCREENWIDTH;
//        [self setupAutoHeightWithBottomView:_emailLabel bottomMargin:30];
        NSLog(@"实例化成员界面");
    }
    return self;
}

-(void)setProjectId:(NSInteger)projectId
{
    //初始化网络请求对象
    self.httpUtil  =[[HttpUtils alloc]init];
    
    _projectId = projectId;
    _memberPartner = [TDUtil encryKeyWithMD5:KEY action:REQUESTMEMBER];
    [self loadMemberData];
}

#pragma mark -下载成员界面数据
-(void)loadMemberData
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KEY,@"key",_memberPartner,@"partner",[NSString stringWithFormat:@"%ld",self.projectId],@"projectId", nil];
    //开始请求
    [self.httpUtil getDataFromAPIWithOps:REQUEST_PROJECT_MEMBER postParam:dic type:0 delegate:self sel:@selector(requestProjectMember:)];
}
-(void)requestProjectMember:(ASIHTTPRequest *)request
{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
//    NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    
    if (jsonDic != nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        if ([status integerValue] == 200) {
            
            NSArray *modelArray = [ProjectDetailMemberModel mj_objectArrayWithKeyValuesArray:jsonDic[@"data"]];
            ProjectDetailMemberModel *model = modelArray[0];
            self.model = model;
            
        }else{
            [[DialogUtil sharedInstance]showDlg:self textOnly:[jsonDic valueForKey:@"message"]];
        }
    }
}


-(void)setModel:(ProjectDetailMemberModel *)model
{
    _model = model;
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.icon]] placeholderImage:[UIImage new]];
    //加载数据
    _iconImage.layer.cornerRadius = 41;
    _iconImage.layer.masksToBounds = YES;
    
    _nameLabel.text = model.name;
    _positionLabel.text = [NSString stringWithFormat:@"%@%@",model.company,model.position];
    _companyType.text = model.industory;
    _addressLabel.text = model.address;
    _emailLabel.text = model.emial;
    _phoneLabel.text = model.telephone;
}


@end
