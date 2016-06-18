//
//  ProjectDetailSceneView.m
//  JinZhiT
//
//  Created by Eugene on 16/5/16.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "ProjectDetailSceneView.h"
#import "ProjectDetailSceneMessageCell.h"
#import "MusicModel.h"
#import "ProjectSceneModel.h"

#define REQUESTSCENE @"requestScene"

@implementation ProjectDetailSceneView

{
    NSString *_scenePartner;
    UISlider *_slider;
    BOOL _isRun;
    MusicModel *_musicModel;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        _scenePartner = [TDUtil encryKeyWithMD5:KEY action:REQUESTSCENE];
        //初始化网络请求对象
        self.httpUtil  =[[HttpUtils alloc]init];
        
        [self createUI];
        
        
    }
    return self;
}

-(void)setProjectId:(NSInteger)projectId
{
    _projectId = projectId;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KEY,@"key",_scenePartner,@"partner",[NSString stringWithFormat:@"%ld",self.projectId],@"projectId", nil];
    //开始请求
    [self.httpUtil getDataFromAPIWithOps:REQUEST_SCENE postParam:dic type:0 delegate:self sel:@selector(requestProjectScene:)];
}

-(void)requestProjectScene:(ASIHTTPRequest *)request
{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
    NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    if (jsonDic != nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        if ([status integerValue] == 200) {
            NSArray *modelArray = [ProjectSceneModel mj_objectArrayWithKeyValuesArray:jsonDic[@"data"]];
            ProjectSceneModel *model = modelArray[0];
            
            _url = model.audioPath;
            
            [self startPlay];
            
        }else{
            [[DialogUtil sharedInstance]showDlg:self textOnly:[jsonDic valueForKey:@"message"]];
        }
    }
}

-(void)createUI
{
    _tableView = [[UITableView alloc]init];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.scrollEnabled = NO;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-50);
    }];
    
    [_tableView setTableHeaderView:[self createHeaderView]];
    [self createFooterView];
}
-(UIView*)createHeaderView
{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
    headerView.backgroundColor = [UIColor whiteColor];
    UIView * lightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    lightView.backgroundColor = [UIColor lightGrayColor];
    lightView.alpha = 0.3;
    [headerView addSubview:lightView];
    
    UIButton * startBtn = [[UIButton alloc]init];
    [startBtn setImage:[UIImage imageNamed:@"iconfont-bofang"] forState:UIControlStateNormal];
    //播放图片
    [startBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    //暂停播放图片
    [startBtn setImage:[UIImage imageNamed:@"iconfont-zengdayinliang"] forState:UIControlStateSelected];
    startBtn.contentMode = UIViewContentModeScaleAspectFit;
    [headerView addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(27);
        make.centerY.mas_equalTo(headerView.mas_centerY).offset(10);
        make.width.height.mas_equalTo(20);
    }];
    
    UILabel *label =[[UILabel alloc]init];
    label.text = @"01:12:23";
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = [UIColor darkGrayColor];
    label.font =[UIFont systemFontOfSize:12];
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView.mas_right).offset(-27);
        make.centerY.mas_equalTo(headerView.mas_centerY).offset(10);
    }];
    
    _slider =[[UISlider alloc]init];
    [_slider addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
    [headerView addSubview:_slider];
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(startBtn.mas_right).offset(20);
        make.centerY.mas_equalTo(headerView.mas_centerY).offset(10);
        make.right.mas_equalTo(label.mas_left).offset(-10);
        make.height.mas_equalTo(5);
    }];
    
    return headerView;
}

-(void)createFooterView
{
    UIView * footer =[[UIView alloc]init];
    
    [self addSubview:footer];
    [footer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    UITextView * text = [[UITextView alloc]init];
    text.layer.cornerRadius = 2;
    text.layer.masksToBounds = YES;
    text.layer.borderColor = [UIColor darkGrayColor].CGColor;
    text.layer.borderWidth = 0.5;
    text.delegate = self;
    
    [footer addSubview:text];
    
    UIButton * btn =[[UIButton alloc]init];
    [btn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:colorBlue];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [footer addSubview:btn];
    
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(btn.mas_left).offset(-5);
    }];
    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footer.mas_top);
        make.right.mas_equalTo(footer.mas_right);
        make.bottom.mas_equalTo(footer.mas_bottom);
        make.width.mas_equalTo(75);
    }];
    
}
#pragma mark -发送信息
-(void)sendMessage:(UIButton*)btn
{
    NSLog(@"发送信息");
}
#pragma mark----初始化 播放
-(void)startPlay
{
    MP3Player*player=[[MP3Player alloc]init];
    if (!player.isPlayMusic) {
        NSString *path = [NSString stringWithFormat:@"%@",_url];
        NSURL *url =[NSURL URLWithString:path];
        
        AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:url];
        player.player = [[AVPlayer alloc]initWithPlayerItem:playerItem];
        
        //进度  帧数 帧率
        __weak AVPlayer *Wplayer = player.player;
        __weak UISlider *Wslider = _slider;
        
        [player.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            //当前时间
            CMTime currentTime=Wplayer.currentItem.currentTime;
            //总时间
            CMTime duration=Wplayer.currentItem.duration;
            //进度＝当前时间/总时间
            float pro=CMTimeGetSeconds(currentTime)/CMTimeGetSeconds(duration);
            [Wslider setValue:pro animated:YES];
        }];
    }
}
#pragma mark -是否播放
-(void)playClick:(UIButton*)btn
{
    MP3Player*player=[[MP3Player alloc]init];
    if (!btn.selected) {
        [player.player play];
        _isRun = YES;
        player.isPlayMusic = YES;

    }else{
        [player.player pause];
        _isRun=NO;
        player.isPlayMusic=NO;
        
    }
    
    btn.selected = !btn.selected;
}
#pragma mark- slider的进度事件
-(void)valueChanged
{
    MP3Player*player=[[MP3Player alloc]init];
    CMTime currentTime=CMTimeMultiplyByFloat64(player.player.currentItem.duration, _slider.value);
    [player.player seekToTime:currentTime];
    
}


#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId =@"ProjectDetailSceneMessageCell";
    ProjectDetailSceneMessageCell * cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ProjectDetailSceneMessageCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        
    }
    return cell;
    
}

@end
