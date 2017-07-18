//
//  MyInfiniteScrollView.m
//  InfiniteScrollView
//
//  Created by Apple on 16/12/14.
//  Copyright © 2016年 lqq. All rights reserved.
//

#import "MyInfiniteScrollView.h"
#import "UIImageView+WebCache.h"

#define scrollViewW  self.frame.size.width
#define scrollViewH  self.frame.size.height


@interface MyInfiniteScrollView()<UIScrollViewDelegate>

@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) NSInteger currPage;


@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;

@property(nonatomic,strong) UIImageView *leftImgView;
@property(nonatomic,strong) UIImageView *centerImgView;
@property(nonatomic,strong) UIImageView *rightImgView;

@property(nonatomic,copy) NSArray *dataAry;

@property(nonatomic,assign) NSInteger maxPage;


@property(nonatomic,assign) BOOL isWebimages;


@end

@implementation MyInfiniteScrollView

- (instancetype)initWithFrame:(CGRect)frame localdataAry:(NSArray *)dataAry
{
    _dataAry = dataAry;
    if (dataAry.count < 2) {
        return nil;
    }
    self = [super initWithFrame:frame];
    if (self) {
        
        [self seUpScrollView];
        
        _isWebimages = NO;
        
        [self seUpImagedataAry:dataAry];
        
        [self setMaxPage:_dataAry.count];
     
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame webdataAry:(NSArray *)dataAry{
    
    _dataAry = dataAry;
    if (dataAry.count < 2) {
        return nil;
    }
    self = [super initWithFrame:frame];
    if (self) {
        
        [self seUpScrollView];
        
        _isWebimages = YES;
        
        [self seUpImagedataAry:dataAry];
        
        [self setMaxPage:_dataAry.count];
        
    }
    return self;
}




- (void)seUpScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:scrollView];
    _scrollView = scrollView;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollViewW * 3, scrollViewH);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
}

- (void)setMaxPage:(NSInteger)maxPage
{
    _maxPage = maxPage;
    // 设置imageView控件
    [self initImageView];
    
    // 设置分页控件
    [self seUpPageControl];
    
    // 添加timer
    [self addTimer];
    
}

- (void)initImageView
{
    UIImageView *leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, scrollViewW, scrollViewH)];
    [self.scrollView addSubview:leftImgView];
    
    UIImageView *centerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(scrollViewW, 0, scrollViewW, scrollViewH)];
    [self.scrollView addSubview:centerImgView];
    
    UIImageView *rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(scrollViewW * 2, 0, scrollViewW, scrollViewH)];
    [self.scrollView addSubview:rightImgView];
    
    _leftImgView = leftImgView;
    _centerImgView = centerImgView;
    _rightImgView = rightImgView;
    
}

- (void)seUpImagedataAry:(NSArray *)dataAry
{
    if (_isWebimages) {
        _dataAry = [dataAry copy];
    }
    _leftImgView.image = [UIImage imageNamed:dataAry[_currPage]];
    _centerImgView.image = [UIImage imageNamed:dataAry[_currPage+1]];
    _rightImgView.image = [UIImage imageNamed:dataAry[_currPage+2]];
}

- (void)seUpPageControl
{
    CGFloat pageX = (scrollViewW ) * 0.5;
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(pageX, scrollViewH - 20-20 , 0, 20)];
    pageControl.numberOfPages = _maxPage;
    pageControl.currentPage = _currPage;
    [self addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)addTimer
{
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

// 滑动
- (void)scroll
{
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + scrollViewW, 0) animated:YES];
}

- (void)changeImgLeftindex:(NSInteger)leftindex centerindex:(NSInteger)centerindex rightindex:(NSInteger)rightindex
{
    
    if (_isWebimages) {
        [_leftImgView sd_setImageWithURL:[NSURL URLWithString:_dataAry[leftindex]] placeholderImage:_placeholderImage];
        [_centerImgView sd_setImageWithURL:[NSURL URLWithString:_dataAry[centerindex]] placeholderImage:_placeholderImage];
        [_rightImgView sd_setImageWithURL:[NSURL URLWithString:_dataAry[rightindex]] placeholderImage:_placeholderImage];
        
    }
    else
    {
        _leftImgView.image = [UIImage imageNamed:_dataAry[leftindex]];
        _centerImgView.image = [UIImage imageNamed:_dataAry[centerindex]];
        _rightImgView.image = [UIImage imageNamed:_dataAry[rightindex]];
    }
    [_scrollView setContentOffset:CGPointMake(scrollViewW, 0) animated:NO];
}

#pragma mark scrollViewdelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.timer == nil) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    [self changeImageWithOffset:self.scrollView.contentOffset.x];
    
}

- (void)changeImageWithOffset:(CGFloat)offsetX
{
    if (offsetX >= scrollViewW * 2)
    {
        _currPage++;
        
        if (_currPage == _maxPage-1)
        {
            [self changeImgLeftindex:_currPage-1 centerindex:_currPage rightindex:0];
        }
        else if (_currPage == _maxPage)
        {
            _currPage = 0;
            [self changeImgLeftindex:_maxPage-1 centerindex:0 rightindex:1];
        }
        else
        {
            [self changeImgLeftindex:_currPage-1 centerindex:_currPage rightindex:_currPage+1];
        }
   }
    
    if (offsetX <= 0)
    {
        _currPage --;
        if (_currPage == 0)
        {
            [self changeImgLeftindex:_maxPage-1 centerindex:0 rightindex:1];
        }
        else if(_currPage == -1)
        {
            _currPage = _maxPage - 1;
            [self changeImgLeftindex:_currPage -1 centerindex:_currPage rightindex:0];
        }
        else
        {
            [self changeImgLeftindex:_currPage-1 centerindex:_currPage rightindex:_currPage+1];
        }
    }
    
    _pageControl.currentPage = _currPage;
}


@end
