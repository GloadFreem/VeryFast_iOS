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
#import "ProjectDetailSceneCellModel.h"
#import "ProjectSceneCommentModel.h"
#import "ProjectPPTModel.h"

#define REQUESTSCENE @"requestScene"
#define REQUESTSCENECOMMENT @"requestProjectSceneCommentList"
#define REQUESTPPT @"requestRecorData"
@implementation ProjectDetailSceneView

{
    NSMutableArray *_dataArray;
    NSString *_scenePartner;
    NSString *_commentPartner;
    NSString *_pptPartner;
    UISlider *_slider;
    BOOL _isRun;
    BOOL _isPPT;
    MusicModel *_musicModel;
    UILabel *_label;
    NSInteger _sceneId;
    NSInteger _page;
    NSMutableArray *_pptArray;
    NSMutableArray *_imageUrlArray;
    NSMutableArray *_nextPageArray;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        _scenePartner = [TDUtil encryKeyWithMD5:KEY action:REQUESTSCENE];
        _commentPartner = [TDUtil encryKeyWithMD5:KEY action: REQUESTSCENECOMMENT];
        _pptPartner = [TDUtil encryKeyWithMD5:KEY action:REQUESTPPT];
        
        _page = 0;
        //初始化网络请求对象
        self.httpUtil  =[[HttpUtils alloc]init];
        if (!_dataArray) {
            _dataArray = [NSMutableArray array];
        }
        if (!_pptArray) {
            _pptArray = [NSMutableArray array];
        }
        if (!_imageUrlArray) {
            _imageUrlArray = [NSMutableArray array];
        }
        if (!_nextPageArray) {
            _nextPageArray = [NSMutableArray array];
        }
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
//    NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    if (jsonDic != nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        if ([status integerValue] == 200) {
            NSArray *modelArray = [ProjectSceneModel mj_objectArrayWithKeyValuesArray:jsonDic[@"data"]];
            ProjectSceneModel *model = modelArray[0];
            
            _url = model.audioPath;
            _sceneId = model.sceneId;
            [self startLoadComment];
            [self startLoadPPT];
            [self startPlay];
            
        }else{
            [[DialogUtil sharedInstance]showDlg:self textOnly:[jsonDic valueForKey:@"message"]];
        }
    }
}
-(void)startLoadPPT
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KEY,@"key",_pptPartner,@"partner",[NSString stringWithFormat:@"%ld",_sceneId],@"sceneId",[NSString stringWithFormat:@"%ld",_page],@"page", nil];
    //开始请求
    [self.httpUtil getDataFromAPIWithOps:REQUEST_RECORDATA postParam:dic type:0 delegate:self sel:@selector(requestScenePPT:)];
}
-(void)requestScenePPT:(ASIHTTPRequest *)request{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
//            NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    if (jsonDic != nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        if ([status integerValue] == 200) {
            _pptArray = [ProjectPPTModel mj_objectArrayWithKeyValuesArray:jsonDic[@"data"]];
            
            for (NSInteger i = 0; i < _pptArray.count; i ++) {
                ProjectPPTModel *model = _pptArray[i];
                [_imageUrlArray addObject:model.imageUrl];
                [_nextPageArray addObject:[NSString stringWithFormat:@"%ld",model.playTime]];
                
            }
            NSLog(@"打印数组个数---%ld",_nextPageArray.count);
            
            _isPPT  = YES;
            
        }else{
        [[DialogUtil sharedInstance]showDlg:self textOnly:[jsonDic valueForKey:@"message"]];
        }
    }
}

-(void)startLoadComment
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:KEY,@"key",_commentPartner,@"partner",[NSString stringWithFormat:@"%ld",_sceneId],@"sceneId",@"0",@"page", nil];
    //开始请求
    [self.httpUtil getDataFromAPIWithOps:REQUEST_SCENE_COMMENT_LIST postParam:dic type:0 delegate:self sel:@selector(requestSceneComment:)];
}
-(void)requestSceneComment:(ASIHTTPRequest *)request
{
    NSString *jsonString = [TDUtil convertGBKDataToUTF8String:request.responseData];
//        NSLog(@"返回:%@",jsonString);
    NSMutableDictionary* jsonDic = [jsonString JSONValue];
    if (jsonDic !=nil) {
        NSString *status = [jsonDic valueForKey:@"status"];
        if ([status integerValue] == 200) {
            NSArray *modelArray = [ProjectSceneCommentModel mj_objectArrayWithKeyValuesArray:jsonDic[@"data"]];
            for (NSInteger i = 0; i < modelArray.count; i ++) {
                ProjectSceneCommentModel *model = modelArray[i];
                ProjectDetailSceneCellModel *cellModel = [ProjectDetailSceneCellModel new];
                cellModel.flag = model.flag;
                cellModel.iconImage = model.users.headSculpture;
                cellModel.name = model.users.name;
                cellModel.content = model.content;
                cellModel.time = model.commentDate;
                [_dataArray addObject:cellModel];
            }
            [_tableView reloadData];
            
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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    [_tableView setTableHeaderView:[self createHeaderView]];
//    [self createFooterView];
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
    label.text = @"00:00:00";
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = [UIColor darkGrayColor];
    label.font =[UIFont systemFontOfSize:12];
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView.mas_right).offset(-27);
        make.centerY.mas_equalTo(headerView.mas_centerY).offset(10);
    }];
    _label = label;
    
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
            
//            static int h = 0,m = 0, s = 0;
            NSInteger current = CMTimeGetSeconds(time);
            
            //实时监听遍历是否换页
            for (NSInteger i = 0; i < _nextPageArray.count; i ++) {
                if (current == [_nextPageArray[i] integerValue]) {
                    
                    NSLog(@"换ppt时间----%ld",[_nextPageArray[i] integerValue]);
                    
                    [_bannerView nextPage:i + 1];
                }
//                else if(current < [_nextPageArray[i] integerValue] ){
//                    [_bannerView nextPage:0];
//                }
            }
            
            if (current) {
                
                if (current <= 59) {
                    _label.text = [NSString stringWithFormat:@"00:00:%ld",current];
                    
                }else if (60 < current  && current <= 3599 ){
                    NSInteger minute = current / 60;
                    NSInteger second = current % 60;
                    _label.text = [NSString stringWithFormat:@"00:%.2ld:%.2ld",(long)minute,(long)second];
                }else{
                    NSInteger hour = current / 3600;
                    NSInteger minute = (current % 3600) / 60;
                    NSInteger second = current % 3600 % 60;
                    _label.text = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",(long)hour,(long)minute,(long)second];
                
                }
                
//                s ++;
//                if (s > 59) {
//                    m ++;
//                    s = 0;
//                    if (m > 59) {
//                        h ++;
//                        m = 0;
//                    }
//                }
//            _label.text = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",h,m,s];
            }
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
    if (_isPPT) {
        if (_imageUrlArray.count) {
            [_bannerView relayoutWithModelArr:_imageUrlArray];
        }
        _isPPT  = NO;
    }
    
    MP3Player*player=[[MP3Player alloc]init];
    if (!btn.selected) {
        [player.player play];
        _isRun = YES;
        player.isPlayMusic = YES;
        _bannerView.scrollView.scrollEnabled = NO;

    }else{
        [player.player pause];
        _isRun=NO;
        player.isPlayMusic=NO;
        _bannerView.scrollView.scrollEnabled = YES;
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
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataArray[indexPath.row];
    return [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProjectDetailSceneMessageCell class] contentViewWidth:[self cellContentViewWith]];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId =@"ProjectDetailSceneMessageCell";
    ProjectDetailSceneMessageCell * cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ProjectDetailSceneMessageCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        
    }
    if (_dataArray.count) {
        cell.model = _dataArray[indexPath.row];
    }
    return cell;
    
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

@end
