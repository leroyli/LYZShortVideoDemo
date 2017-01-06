//
//  Utils.h
//  ShortVideoDemo
//
//  Created by artios on 2017/1/4.
//  Copyright © 2017年 artios. All rights reserved.
//

/*
 *
 * 如果下载视频的时候想根据userid相关数据给文件命名，可以使用这个工具类
 *
 *
 */

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MBProgressHUD+LYZ.h"

@interface Utils : NSObject

@property (nonatomic, strong) MBProgressHUD *hud;

+ (instancetype)shareInstance;

+ (void)downloadShareVideoWithController:(UIViewController *)vc
                                     Url:(NSString *)url
                                FileName:(NSString *)name
                        CompeletionBlock:(void(^)())compeletionBlock;


+ (BOOL)isSavedFileToLocalWithfileName:(NSString *)fileName;

+ (NSString *)cachePathWithFileName:(NSString *)name;

+ (UIImage*) thumbnailImageForVideo:(NSString *)videoURL
                             atTime:(NSTimeInterval)time;


@end
