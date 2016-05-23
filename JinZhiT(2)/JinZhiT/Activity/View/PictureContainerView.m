//
//  PictureContainerView.m
//  JinZhiT
//
//  Created by Eugene on 16/5/20.
//  Copyright © 2016年 Eugene. All rights reserved.
//

#import "PictureContainerView.h"

#import "SDPhotoBrowser.h"

@interface PictureContainerView() <SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imageViewArray;

@end

@implementation PictureContainerView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    //创建 imageView
    NSMutableArray *temp = [NSMutableArray new];
    for (int i =0; i<9; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor redColor];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    self.imageViewArray = [temp copy];
}

-(void)setPictureStringArray:(NSArray *)pictureStringArray
{
    _pictureStringArray = pictureStringArray;
    
    //移除没有图片的占位imageView
    for (long i =_pictureStringArray.count; i<self.imageViewArray.count; i++) {
        UIImageView *imageView =[self.imageViewArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    //初步判断高度
    if (_pictureStringArray.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    //布局imageView
    CGFloat imageW = 101*WIDTHCONFIG;
    CGFloat imageH = 84*HEIGHTCONFIG;
    CGFloat margin =5;
    for (int index = 0; index < _pictureStringArray.count; index++) {
        //计算imageView在几行几列
        int row = index / 3;
        int column = index % 3;
        UIImageView *imageView = [_imageViewArray objectAtIndex:index];
        imageView.hidden = NO;
        imageView.image = [UIImage imageNamed:_pictureStringArray[index]];
        imageView.frame = CGRectMake((margin + imageW) * column, row * (margin + imageH), imageW, imageH);
    }
    CGFloat w = 3 * imageW + 2 * margin;
    int num = ceilf(_pictureStringArray.count * 1.0 / 3);
    CGFloat h = num * imageH + (num - 1) *margin;
    
    
    self.height = h;
    self.width = w;
    
    self.fixedWith = @(w);
    self.fixedHeight = @(h);
    NSLog(@"视图尺寸为：%lf   %lf",w,h);
}

#pragma mark - private  actions
-(void)tapImageView:(UITapGestureRecognizer*)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser * browser = [[SDPhotoBrowser alloc]init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.pictureStringArray.count;
    browser.delegate =self;
    [browser show];
}

#pragma mark - SDphotoBrowserDelegate
-(NSURL*)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.pictureStringArray[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

-(UIImage*)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}
@end