//
//  ViewController.m
//  XZWeChatIconDemo
//
//  Created by 徐章 on 2016/11/29.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "ViewController.h"
#import "XZIconImageHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *iconArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 8; i++) {
        
        [iconArray addObject:[UIImage imageNamed:@"icon.png"]];
    }
    
    UIImage *image = [XZIconImageHelper createIcon:iconArray size:CGSizeMake(200, 200) iconMargin:5];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    imageView.layer.borderColor = [UIColor grayColor].CGColor;
    imageView.layer.borderWidth = 1.0f;
    
    imageView.image = image;
    
    [self.view addSubview:imageView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
