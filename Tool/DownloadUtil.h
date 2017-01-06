//
//  DownloadUtil.h
//  ShortVideoDemo
//
//  Created by artios on 2017/1/6.
//  Copyright © 2017年 artios. All rights reserved.
//

/*
 * 下载视频的时候从url截取字符串给文件命名
 *
 */



#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MBProgressHUD+LYZ.h"

@interface DownloadUtil : NSObject

@property (nonatomic, strong) MBProgressHUD *hud;

+ (instancetype)shareInstance;

+ (void)downloadShareVideoWithUrl:(NSString *)url
                 CompeletionBlock:(void(^)())compeletionBlock;

+ (NSString *)cachePathWithUrl:(NSString *)url;

+ (BOOL)isSavedFileToLocalWithUrl:(NSString *)url;

+ (UIImage *)thumbnailImageForVideo:(NSString *)videoURL
                             atTime:(NSTimeInterval)time;

@end
