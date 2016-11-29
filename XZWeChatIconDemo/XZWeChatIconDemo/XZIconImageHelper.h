//
//  XZIconImageHelper.h
//  XZWeChatIconDemo
//
//  Created by 徐章 on 2016/11/29.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XZIconImageHelper : NSObject


/**
 创建头像图片

 @param imageArray icon的图片数组
 @param size 生成的图片的size
 @param iconMargin 每个icon与四周的边距
 @return 头像图片
 */
+ (UIImage *)createIcon:(NSArray<UIImage *> *)imageArray size:(CGSize)size iconMargin:(CGFloat)iconMargin;

@end
