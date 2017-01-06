//
//  ViewController.m
//  LYZShortVideoDemo
//
//  Created by artios on 2017/1/6.
//  Copyright © 2017年 artios. All rights reserved.
//

#import "ViewController.h"
#import "LYZPlayerViewController.h"
#import "LYZDownloadTool.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *urlArray;
@property (nonatomic, strong) UIView  *bottomView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupViews];
}

- (void)setupViews{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
    self.bottomView.center = self.view.center;
    self.bottomView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.bottomView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"video_play"] forState:UIControlStateNormal];
    button.frame = CGRectMake(60, 40, 60, 60);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:button];
    
    self.urlArray = @[@"http://7xqhmn.media1.z0.glb.clouddn.com/femorning-20161106.mp4",
                      @"http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4",
                      @"http://baobab.wdjcdn.com/1456117847747a_x264.mp4",
                      @"http://baobab.wdjcdn.com/14525705791193.mp4",
                      @"http://baobab.wdjcdn.com/1456459181808howtoloseweight_x264.mp4",
                      @"http://baobab.wdjcdn.com/1455968234865481297704.mp4",
                      @"http://baobab.wdjcdn.com/1455782903700jy.mp4",
                      @"http://baobab.wdjcdn.com/14564977406580.mp4",
                      @"http://baobab.wdjcdn.com/1456316686552The.mp4",
                      @"http://baobab.wdjcdn.com/1456480115661mtl.mp4",
                      @"http://baobab.wdjcdn.com/1456665467509qingshu.mp4",
                      @"http://baobab.wdjcdn.com/1455614108256t(2).mp4",
                      @"http://baobab.wdjcdn.com/1456317490140jiyiyuetai_x264.mp4",
                      @"http://baobab.wdjcdn.com/1455888619273255747085_x264.mp4",
                      @"http://baobab.wdjcdn.com/1456734464766B(13).mp4",
                      @"http://baobab.wdjcdn.com/1456653443902B.mp4",
                      @"http://baobab.wdjcdn.com/1456231710844S(24).mp4"];
    
}

- (void)buttonAction:(UIButton *)sender{
    
    [sender setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
    [LYZDownloadTool downloadShareVideoWithUrl:self.urlArray[1] CompeletionBlock:^{
        [self openVideoVCWithUrl:self.urlArray[1]];
    }];
    
    [LYZDownloadTool shareInstance].progressView.frame = CGRectMake(60, 40, 60, 60);
    [self.bottomView addSubview:[LYZDownloadTool shareInstance].progressView];
    
}

- (void)openVideoVCWithUrl:(NSString *)url{
    
    LYZPlayerViewController *lvc = [[LYZPlayerViewController alloc] init];
    lvc.videoUrl = url;
    [self presentViewController:lvc animated:NO completion:nil];
}



/*
- (void)setupViews{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor redColor]];
    button.frame = CGRectMake(100, 100, 200, 150);
    button.center = self.view.center;
    button.layer.cornerRadius = 20;
    button.layer.masksToBounds = YES;
    [button setTitle:@"open share video" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.urlArray = @[@"http://7xqhmn.media1.z0.glb.clouddn.com/femorning-20161106.mp4",
                      @"http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4",
                      @"http://baobab.wdjcdn.com/1456117847747a_x264.mp4",
                      @"http://baobab.wdjcdn.com/14525705791193.mp4",
                      @"http://baobab.wdjcdn.com/1456459181808howtoloseweight_x264.mp4",
                      @"http://baobab.wdjcdn.com/1455968234865481297704.mp4",
                      @"http://baobab.wdjcdn.com/1455782903700jy.mp4",
                      @"http://baobab.wdjcdn.com/14564977406580.mp4",
                      @"http://baobab.wdjcdn.com/1456316686552The.mp4",
                      @"http://baobab.wdjcdn.com/1456480115661mtl.mp4",
                      @"http://baobab.wdjcdn.com/1456665467509qingshu.mp4",
                      @"http://baobab.wdjcdn.com/1455614108256t(2).mp4",
                      @"http://baobab.wdjcdn.com/1456317490140jiyiyuetai_x264.mp4",
                      @"http://baobab.wdjcdn.com/1455888619273255747085_x264.mp4",
                      @"http://baobab.wdjcdn.com/1456734464766B(13).mp4",
                      @"http://baobab.wdjcdn.com/1456653443902B.mp4",
                      @"http://baobab.wdjcdn.com/1456231710844S(24).mp4"];
    
}

- (void)buttonAction:(UIButton *)sender{
    
    LYZPlayerViewController *lvc = [[LYZPlayerViewController alloc] init];
    lvc.videoUrl = self.urlArray[0];
    [self presentViewController:lvc animated:NO completion:nil];
}
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
