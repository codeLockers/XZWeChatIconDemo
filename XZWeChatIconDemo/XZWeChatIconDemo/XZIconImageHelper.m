//
//  XZIconImageHelper.m
//  XZWeChatIconDemo
//
//  Created by 徐章 on 2016/11/29.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZIconImageHelper.h"

@implementation XZIconImageHelper

+ (UIImage *)createIcon:(NSArray<UIImage *> *)imageArray size:(CGSize)size iconMargin:(CGFloat)iconMargin{

    NSAssert(imageArray, @"图片数组不能为空");
    NSAssert(imageArray.count != 0, @"图片数组不能为空");
    NSAssert(iconMargin >= 0, @"icon之间的距离必须大于等于0");
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    containerView.backgroundColor = [UIColor whiteColor];
    
    if (imageArray.count == 1) {
        return [self iconCountOnlyOne:imageArray inView:containerView size:size iconMargin:iconMargin];
    }else if (imageArray.count > 1 && imageArray.count <= 4){
        return [self iconCountFromTwoToFour:imageArray inView:containerView size:size iconMargin:iconMargin];
    }else{
        return [self iconCountMoreThanfour:imageArray inView:containerView size:size iconMargin:iconMargin];
    }
    
    return nil;
}

+ (UIImage *)iconCountOnlyOne:(NSArray*)imageArray inView:(UIView *)containerView size:(CGSize)size iconMargin:(CGFloat)iconMargin{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconMargin, iconMargin, size.width-2*iconMargin, size.height-2*iconMargin)];
    imageView.image = imageArray.firstObject;
    [containerView addSubview:imageView];
    
    return [self createGroupImage:size container:containerView];
}

+ (UIImage *)iconCountFromTwoToFour:(NSArray *)imageArray inView:(UIView *)containerView size:(CGSize)size iconMargin:(CGFloat)iconMargin{
    
    //每个子icon的边长
    CGFloat length = (size.width - 3*iconMargin)/2.0f;
    
    if (imageArray.count == 2) {
        
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, length, length)];
        imageView1.center = CGPointMake(iconMargin+length/2.0f, containerView.center.y);
        imageView1.image = imageArray.firstObject;
        
        UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, length, length)];
        imageView2.center = CGPointMake(iconMargin*2+length+length/2.0f, containerView.center.y);
        imageView2.image = imageArray[1];
        
        [containerView addSubview:imageView1];
        [containerView addSubview:imageView2];
        
    }else if (imageArray.count == 3){
    
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, length, length)];
        imageView1.center = CGPointMake(containerView.center.x, iconMargin+length/2.0f);
        imageView1.image = imageArray.firstObject;
        
        UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, length, length)];
        imageView2.center = CGPointMake(iconMargin+length/2.0f, iconMargin*2+length+length/2.0f);
        imageView2.image = imageArray[1];
        
        UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, length, length)];
        imageView3.center = CGPointMake(iconMargin*2+length+length/2.0f, iconMargin*2+length+length/2.0f);
        imageView3.image = imageArray[2];
        
        [containerView addSubview:imageView1];
        [containerView addSubview:imageView2];
        [containerView addSubview:imageView3];
        
    }else if (imageArray.count == 4){
        
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, length, length)];
        imageView1.center = CGPointMake(iconMargin+length/2, iconMargin+length/2);
        imageView1.image = imageArray.firstObject;
        
        UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, length, length)];
        imageView2.center = CGPointMake(iconMargin*2+length+length/2.0f, iconMargin+length/2);
        imageView2.image = imageArray[1];
        
        UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, length, length)];
        imageView3.center = CGPointMake(iconMargin+length/2.0f, iconMargin*2+length+length/2.0f);
        imageView3.image = imageArray[2];
        
        UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, length, length)];
        imageView4.center = CGPointMake(iconMargin*2+length+length/2.0f, iconMargin*2+length+length/2.0f);
        imageView4.image = imageArray[3];
        
        [containerView addSubview:imageView1];
        [containerView addSubview:imageView2];
        [containerView addSubview:imageView3];
        [containerView addSubview:imageView4];
    }
    
    return [self createGroupImage:size container:containerView];
}

+ (UIImage *)iconCountMoreThanfour:(NSArray*)imageArray inView:(UIView *)containerView size:(CGSize)size iconMargin:(CGFloat)iconMargin{
    
    //计算每一行的icon个数
    NSInteger rowCount = ceil(sqrtf(imageArray.count));
//    NSLog(@"%ld",(long)rowCount);
    
    //每个icon的边长
    CGFloat length = (size.width - (rowCount+1)*iconMargin)/rowCount;
    NSAssert(length > 0, @"图片太多已经放不下了");
    
    //计算一共需要多少行
    
    NSNumber *number = [[NSNumber alloc] initWithInteger:rowCount];
    NSInteger row = ceilf(imageArray.count / [number floatValue]);
    NSInteger leftCount = imageArray.count % rowCount;
    
    //上下边距
    CGFloat verticalMargin = (size.height - (row - 1)*iconMargin - row*length)/2.0f;
    //第一行的水平边距
    CGFloat horizontalMargin = (size.width - (leftCount - 1)*iconMargin - leftCount*length)/2.0f;
    
    [imageArray enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger index, BOOL * _Nonnull stop) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        
        if (leftCount == 0) {
            
            NSInteger tmpRow = index/rowCount;
            NSInteger tmpCloum = index%rowCount;
            imageView.frame = CGRectMake(tmpCloum*length+(tmpCloum+1)*iconMargin, tmpRow*(length+iconMargin)+verticalMargin, length, length);
            
        }else{
        
            if (index < leftCount) {
                imageView.frame = CGRectMake(horizontalMargin+index*(length+iconMargin), verticalMargin, length, length);
            }else{
                NSInteger tmpIndex = index - leftCount;

                NSInteger row = tmpIndex/rowCount + 1;
                NSInteger cloum = tmpIndex%rowCount;

                imageView.frame = CGRectMake((cloum + 1)*iconMargin+cloum*length, row*(length+iconMargin)+verticalMargin, length, length);
            }
        }
        
        [containerView addSubview:imageView];
    }];
    return [self createGroupImage:size container:containerView];
}


+ (UIImage *)createGroupImage:(CGSize)size container:(UIView *)containerView{
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [containerView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
