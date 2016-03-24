//
//  PicScrollView.m
//  	
//
//  Created by 徐茂怀 on 16/3/23.
//  Copyright © 2016年 kanke. All rights reserved.
//

#import "PicScrollView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface PicScrollView ()<UIScrollViewDelegate>
@property (nonatomic, assign)NSInteger total;
@end
@implementation PicScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
       
    }
    return self;
}
-(void)scrollViewWith:(NSInteger)picNum Pictol:(NSInteger)picTol picArr:(NSArray *)picArr
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _scrollView.delegate = self;
    _total = picTol;
    _scrollView.contentSize = CGSizeMake(WIDTH * picTol, 1);
    _scrollView.contentOffset = CGPointMake(WIDTH * picNum, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
 
    [self addSubview:_scrollView];
    for (NSInteger i = 0; i < picArr.count; i ++) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT)];
        scrollView.minimumZoomScale = 1.0;
        scrollView.maximumZoomScale = 2.0;
        scrollView.delegate = self;
        scrollView.tag = i + 2400;
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.center = [UIApplication sharedApplication].keyWindow.center;
        CGPoint point = [UIApplication sharedApplication].keyWindow.center;
        imageView.frame = CGRectMake(point.x - WIDTH / 2, point.y - WIDTH / 2, WIDTH, WIDTH);
        [scrollView addSubview:imageView];
        [_scrollView addSubview:scrollView];
        imageView.image = [UIImage imageNamed:picArr[i]];
        
        //双击放大缩小
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToZoom:)];
        doubleTap.numberOfTapsRequired = 2;
        doubleTap.numberOfTouchesRequired = 1;
        [scrollView addGestureRecognizer:doubleTap];
        //点击事件
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuper)];
        [singleTap requireGestureRecognizerToFail:doubleTap];
        
        [scrollView addGestureRecognizer:singleTap];
        [imageView setTag:1];
    }
}

-(void)tapToZoom:(UITapGestureRecognizer *)tap
{
    UIScrollView *zoomable = (UIScrollView*)tap.view;
    if (zoomable.zoomScale > 1.0) {
        [zoomable setZoomScale:1 animated:YES];
    } else {
        [zoomable setZoomScale:2 animated:YES];
    }
}
#pragma mark 缩放中走的方法
-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (scrollView != _scrollView) {
        UIImageView *imageView = (UIImageView *)[scrollView viewWithTag:1];
        CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
        (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
        CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
        (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
        imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    }
}
#pragma mark 缩放停止
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    NSLog(@"缩放停止    %.2f", scale);
}

#pragma mark 缩放所对应的视图
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView != _scrollView) {
        UIImageView *imageView = [scrollView viewWithTag:1];
        return imageView;
        
    }
    return nil;
}


-(void)removeFromSuper
{
    [_scrollView removeFromSuperview];
    [self removeFromSuperview];
    [self.delegate removeImageDelegate];
}

@end
