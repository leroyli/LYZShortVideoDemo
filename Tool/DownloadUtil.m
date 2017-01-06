//
//  DownloadUtil.m
//  ShortVideoDemo
//
//  Created by artios on 2017/1/6.
//  Copyright © 2017年 artios. All rights reserved.
//

#import "DownloadUtil.h"
@import AVFoundation;

@interface DownloadUtil ()

@end

@implementation DownloadUtil
static DownloadUtil* _instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

/**
 *
 * 下载视频文件
 *
 @param url 视频url
 @param compeletionBlock 下载完成后的block
 */
+ (void)downloadShareVideoWithUrl:(NSString *)url
                 CompeletionBlock:(void(^)())compeletionBlock
{
    if (url == nil) {return;}
    
    [DownloadUtil shareInstance].hud = [MBProgressHUD showProgressToView:nil ProgressMode:MBProgressHUDModeDeterminate Text:@"下载中..."];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        float progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        [DownloadUtil shareInstance].hud.progress = progress;
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:[self cachePathWithUrl:url]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            if (compeletionBlock) {
                compeletionBlock();
            }
        });
        
    }];
    
    [downloadTask resume];
    
}


/**
 *
 * 缓存文件到本地
 *
 @param url 视频url
 @return NSString
 */
+ (NSString *)cachePathWithUrl:(NSString *)url{
    
    if (url == nil) {return @"";}
    NSString      *fileName      = [self fileNameWithUrl:url];
    NSFileManager *fileManager   = [[NSFileManager alloc] init];
    NSString      *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/shareVideo", pathDocuments];
    NSString *fullPath = [createPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",fileName]];
    
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"FileDir is exists.");
    }
    
    return fullPath;
}


/**
 * 判断是否已缓存到本地
 *
 @param url 视频url
 @return BOOL
 */
+ (BOOL)isSavedFileToLocalWithUrl:(NSString *)url{
    // 判断是否已经离线下载了
    if (url == nil) {return NO;}
    NSString *path = [self cachePathWithUrl:url];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:path]) {
        return YES;
    }
    return NO;
}


/**
 * 获取视频第一帧
 *
 @param videoURL 视频URL
 @param time 第几帧
 @return UIImage
 */
+ (UIImage *)thumbnailImageForVideo:(NSString *)videoURL
                             atTime:(NSTimeInterval)time
{
    AVURLAsset            *asset = [[AVURLAsset alloc] initWithURL:[NSURL URLWithString:videoURL] options:nil];
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef     thumbnailImageRef  = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError        *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
}


/**
 * 根据url生成文件名
 *
 @param url 视频url
 @return 文件名
 */
+ (NSString *)fileNameWithUrl:(NSString *)url{
    if (url == nil) {return @"";}
    NSArray  *strArray  = [url componentsSeparatedByString:@"."];
    NSString *nameStr   = strArray[2];
    NSArray  *nameArray = [nameStr componentsSeparatedByString:@"/"];
    NSString *fileName;
    
    if ([nameStr containsString:@"/"]) {
        fileName = nameArray[1];
    }else{
        fileName = nameStr;
    }
    
    return fileName;
}





@end
