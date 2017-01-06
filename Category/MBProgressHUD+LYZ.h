//
//  MBProgressHUD+LYZ.h
//  ShortVideoDemo
//
//  Created by artios on 2017/1/6.
//  Copyright © 2017年 artios. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (LYZ)

/**
 *  自定义图片的提示，1s后自动消息
 *
 @param iconName iconName
 @param title title
 @param view view
 */
+ (void)showCustomIcon:(NSString *)iconName Title:(NSString *)title ToView:(UIView *)view;


/**
 *  自动消失成功提示，带默认图
 *
 *  @param success 要显示的文字
 *  @param view    要添加的view
 */
+ (void)showSuccess:(NSString *)success ToView:(UIView *)view;


/**
 *  自动消失错误提示,带默认图
 *
 *  @param error 要显示的错误文字
 *  @param view  要添加的View
 */
+ (void)showError:(NSString *)error ToView:(UIView *)view;


/**
 *  文字+菊花提示,不自动消失
 *
 *  @param message 要显示的文字
 *  @param view    要添加的View
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showMessage:(NSString *)message ToView:(UIView *)view;


/**
 *  快速显示一条提示信息
 *
 @param message message
 */
+ (void)showAutoMessage:(NSString *)message;


/**
 *  自动消失提示，无图
 *
 *  @param message 要显示的文字
 *  @param view    要添加的View
 */
+ (void)showAutoMessage:(NSString *)message ToView:(UIView *)view;


/**
 *  自定义停留时间，有图
 *
 @param message message
 @param view view
 */
+(void)showIconMessage:(NSString *)message ToView:(UIView *)view;


/**
 *  自定义停留时间，无图
 *
 @param message message
 @param view view
 @param time time
 */
+(void)showMessage:(NSString *)message ToView:(UIView *)view RemainTime:(CGFloat)time;


/**
 *  加载视图
 *
 *  @param view 要添加的View
 */
+ (void)showLoadToView:(UIView *)view;


/**
 *  进度条View
 *
 @param view 要添加的View
 @param mode 进度条的样式
 @param text 显示的文字
 @return hud
 */
+ (MBProgressHUD *)showProgressToView:(UIView *)view ProgressMode:(MBProgressHUDMode)mode Text:(NSString *)text;


/**
 *  隐藏ProgressView
 *
 *  @param view superView
 */
+ (void)hideHUDForView:(UIView *)view;


/**
 *  快速从window中隐藏ProgressView
 */
+ (void)hideHUD;


//下载视图
+(void)showDownloadToView:(UIView *)view;



@end
