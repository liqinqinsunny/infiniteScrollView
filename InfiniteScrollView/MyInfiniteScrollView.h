//
//  MyInfiniteScrollView.h
//  InfiniteScrollView
//
//  Created by Apple on 16/12/14.
//  Copyright © 2016年 lqq. All rights reserved.
//  无限循环

#import <UIKit/UIKit.h>

@interface MyInfiniteScrollView : UIView


- (instancetype)initWithFrame:(CGRect)frame localdataAry:(NSArray *)dataAry;

- (instancetype)initWithFrame:(CGRect)frame webdataAry:(NSArray *)dataAry;


@property(nonatomic,strong) UIImage *placeholderImage;

@end
