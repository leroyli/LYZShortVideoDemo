//
//  LYZDownloadTool.h
//  LYZShortVideoDemo
//
//  Created by artios on 2017/1/6.
//  Copyright © 2017年 artios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "SDPieProgressView.h"

@interface LYZDownloadTool : NSObject

@property (nonatomic, strong) SDPieProgressView *progressView;


+ (instancetype)shareInstance;

+ (void)downloadShareVideoWithUrl:(NSString *)url
                 CompeletionBlock:(void(^)())compeletionBlock;

+ (NSString *)cachePathWithUrl:(NSString *)url;

+ (BOOL)isSavedFileToLocalWithUrl:(NSString *)url;

+ (UIImage *)thumbnailImageForVideo:(NSString *)videoURL
                             atTime:(NSTimeInterval)time;

@end
