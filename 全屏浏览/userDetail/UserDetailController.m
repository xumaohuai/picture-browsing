//
//  UserDetailController.m
//  KanKeHuDong
//
//  Created by 徐茂怀 on 16/3/22.
//  Copyright © 2016年 kanke. All rights reserved.
//

#import "UserDetailController.h"
#import "userDetailView.h"
#import "PicScrollView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface UserDetailController ()<removeImgDelegate>
@property (nonatomic, strong)userDetailView *userDetailView;
@property (nonatomic, assign)CGRect transformedFrame;
@property (nonatomic, strong)UIImageView *lookImg;
@property (nonatomic, strong)PicScrollView *picScroll;
@property (nonatomic, strong)NSArray *ImgList;
@end

@implementation UserDetailController

- (void)viewDidLoad {
    _userDetailView = [[NSBundle mainBundle]loadNibNamed:@"userDetailView" owner:self options:nil].lastObject;
    _userDetailView.frame = CGRectMake(0, 0, _contentScroll.frame.size.width, _contentScroll.frame.size.height);
    [_contentScroll addSubview:_userDetailView];
    self.contentScroll.contentSize = CGSizeMake(0, 600);
    [self getData];
}

-(void)getData
{
    NSArray *titleArr = [NSArray arrayWithObjects:@"篮球",@"足球",@"排球", nil];
    _ImgList = [NSArray arrayWithObjects:@"h1.jpg",@"h2.jpg",@"h3.jpg",@"h4.jpg", nil];
            for (NSInteger i = 0; i < _ImgList.count; i ++) {
                UIImageView *image = (UIImageView *)[_userDetailView viewWithTag:900 + i];
                image.image = [UIImage imageNamed:_ImgList[i]];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImage:)];
                image.userInteractionEnabled = YES;
                [image addGestureRecognizer:tap];
            }
            static  NSInteger contentX = 130;
            for (NSInteger num = 0; num < titleArr.count; num++) {
               
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.frame = CGRectMake(contentX, 12, [self stringWidth:titleArr[num]], 30);
                [button setTitle:titleArr[num] forState:UIControlStateNormal];
                button.layer.masksToBounds = YES;
                button.layer.cornerRadius = 15 ;
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                button.backgroundColor = [UIColor colorWithRed:0 green:0.68 blue:0.94 alpha:1];
                contentX += [self stringWidth:titleArr[num]] + 5;
                
                [_userDetailView.userInterstView addSubview:button];
            }
    
}


-(void)touchImage:(UITapGestureRecognizer *)tap
{
    UIImageView *tapimageView = (UIImageView *)tap.view;
      _transformedFrame = [tapimageView.superview convertRect:tapimageView.frame toView:[UIApplication sharedApplication].keyWindow];
    _lookImg = [[UIImageView alloc]initWithFrame:_transformedFrame];
        _lookImg.image = tapimageView.image;
        [[UIApplication sharedApplication].keyWindow addSubview:_lookImg];
    [UIView animateWithDuration:.5 animations:^{
        _lookImg.center = [UIApplication sharedApplication].keyWindow.center;
        CGPoint point = [UIApplication sharedApplication].keyWindow.center;
        _lookImg.frame = CGRectMake(point.x - WIDTH / 2, point.y - WIDTH / 2, WIDTH, WIDTH);
    } completion:^(BOOL finished) {
        _picScroll = [[PicScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _picScroll.delegate = self;
        [_picScroll scrollViewWith:tapimageView.tag - 900 Pictol:_ImgList.count picArr:_ImgList];
         [[UIApplication sharedApplication].keyWindow addSubview:_picScroll];
    }];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
        _lookImg.userInteractionEnabled = YES;
        [_lookImg addGestureRecognizer:tap1];
    
}

-(void)removeImageDelegate
{
  NSInteger i =   _picScroll.scrollView.contentOffset.x / WIDTH;
    UIImageView *imageView = [self.userDetailView viewWithTag:900 +i];
    _transformedFrame = [imageView.superview convertRect:imageView.frame toView:[UIApplication sharedApplication].keyWindow];
    _lookImg.image = [UIImage imageNamed:_ImgList[i]];
    [UIView animateWithDuration:1 animations:^{
        _lookImg.frame = _transformedFrame;
        
    } completion:^(BOOL finished) {
        [_lookImg removeFromSuperview];
        _lookImg = nil;
    }];
}

-(void)tapImage:(UITapGestureRecognizer *)tap
{
   
   
}
-(NSInteger)stringWidth:(NSString *)string
{
    return string.length * 24;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
