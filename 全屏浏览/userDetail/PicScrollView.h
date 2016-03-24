//
//  PicScrollView.h
//  	
//
//  Created by 徐茂怀 on 16/3/23.
//  Copyright © 2016年 kanke. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol removeImgDelegate <NSObject>

-(void)removeImageDelegate;

@end

@interface PicScrollView : UIView
@property (nonatomic, strong) UIScrollView *scrollView;
-(void)scrollViewWith:(NSInteger )picNum
               Pictol:(NSInteger)picTol
               picArr:(NSArray *)picArr;
-(void)removeFromSuper;
@property (nonatomic, assign)id<removeImgDelegate>delegate;
@end
