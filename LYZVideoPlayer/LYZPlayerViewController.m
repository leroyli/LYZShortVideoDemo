//
//  LYZPlayerViewController.m
//  ShortVideoDemo
//
//  Created by artios on 2017/1/6.
//  Copyright © 2017年 artios. All rights reserved.
//

#import "LYZPlayerViewController.h"
#import "DownloadUtil.h"
#import "MBProgressHUD+LYZ.h"
#import "Masonry.h"
@import AVFoundation;

@interface LYZPlayerViewController ()

@property (nonatomic, strong) AVPlayer      *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) UIImageView   *thumbImgView;
@property (nonatomic, strong) UIView        *playerView;

@end

@implementation LYZPlayerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setOrientationNoti];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
}


/**
 * 初始化
 */
- (void)setup{
    
    BOOL isSaved =  [DownloadUtil isSavedFileToLocalWithUrl:self.videoUrl];
    
    if (isSaved)
    {
        [self setupPlayer];
    }
    else
    {
        [self setupThumbImage];
        [DownloadUtil downloadShareVideoWithUrl:self.videoUrl CompeletionBlock:^{
            [self closeThumbImgView];
            [self setupPlayer];
        }];
        
        if ([DownloadUtil shareInstance].hud) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
            [[DownloadUtil shareInstance].hud.backgroundView addGestureRecognizer:tap];
        }
    }
}


/**
 * 设置播放器
 */
- (void)setupPlayer{
    
    [self.view addSubview:self.playerView];
    
    NSString *filePath = [DownloadUtil cachePathWithUrl:self.videoUrl];
    AVAsset *asset = [AVAsset assetWithURL:[NSURL fileURLWithPath:filePath]];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.playerView.bounds;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.playerView.layer addSublayer:self.playerLayer];
    
    [self.player play];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
    [self.view addGestureRecognizer:tap];
    
}


/**
 * 添加通知
 */
- (void)setOrientationNoti{
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}


/**
 * 监听设备旋转
 *
 @param interfaceOrientation interfaceOrientation
 */
- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation
{
    //1.获取 当前设备 实例
    UIDevice *device = [UIDevice currentDevice];
    // 竖屏
    if (device.orientation == UIDeviceOrientationPortrait || device.orientation == UIDeviceOrientationPortraitUpsideDown) {
        [self resetLayerWithWidth:self.view.bounds.size.height Height:self.view.bounds.size.width];
    }
    // 横屏
    if (device.orientation == UIDeviceOrientationLandscapeLeft || device.orientation == UIDeviceOrientationLandscapeRight) {
        [self resetLayerWithWidth:self.view.bounds.size.height Height:self.view.bounds.size.width];
    }
    
}


/**
 * 重新布局
 *
 @param width width
 @param height height
 */
- (void)resetLayerWithWidth:(CGFloat)width Height:(CGFloat)height{
    
    self.playerView.frame = CGRectMake(0, 0, width, height);
    self.playerLayer.frame = CGRectMake(0, 0, width, height);
    
    [self.view layoutSubviews];
    [self.playerView layoutSubviews];
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tap {
    if ([DownloadUtil shareInstance].hud) {[MBProgressHUD hideHUD];}
    
    [self.player pause];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.25];
    [animation setType: kCATransitionFade];
    
    [animation setSubtype: kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:NO];
    } else {
        [self dismissViewControllerAnimated:NO completion:NULL];
    }
}


/**
 * 添加预览图
 */
- (void)setupThumbImage{
    
    self.thumbImgView   = [[UIImageView alloc] initWithFrame:self.view.bounds];
    UIImage *thumbImage = [DownloadUtil thumbnailImageForVideo:self.videoUrl atTime:20];
    self.thumbImgView.image = thumbImage;
    [self.view addSubview:self.thumbImgView];
}


/**
 * 移除预览图
 */
- (void)closeThumbImgView{
    if ([DownloadUtil shareInstance].hud) {[MBProgressHUD hideHUD];}
    [self.thumbImgView removeFromSuperview];
    self.thumbImgView = nil;
}

- (UIView *)playerView{
    if (!_playerView) {
        _playerView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _playerView;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:nil
     ];
    [[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
