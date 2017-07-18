//
//  ViewController.m
//  InfiniteScrollView
//
//  Created by Apple on 16/12/14.
//  Copyright © 2016年 lqq. All rights reserved.
//

#import "ViewController.h"
#import "MyInfiniteScrollView.h"
#define screenWidth    [UIScreen mainScreen].bounds.size.width
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSArray *ary = [NSArray arrayWithObjects:@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg", nil];
//    
//    MyInfiniteScrollView *infiniteScrollView = [[MyInfiniteScrollView alloc]initWithFrame:CGRectMake(0, 0,screenWidth, 300) localdataAry:ary];
//    [self.view addSubview:infiniteScrollView];
    

    NSArray *webAry = [NSArray arrayWithObjects:@"http://ws.xzhushou.cn/focusimg/201508201549023.jpg",@"http://ws.xzhushou.cn/focusimg/52.jpg",@"http://ws.xzhushou.cn/focusimg/51.jpg",@"http://ws.xzhushou.cn/focusimg/50.jpg",nil];

    MyInfiniteScrollView *infiniteView = [[MyInfiniteScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 300) webdataAry:webAry];
    infiniteView.placeholderImage = [UIImage imageNamed:@"placeholderImage"];
    [self.view addSubview:infiniteView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
