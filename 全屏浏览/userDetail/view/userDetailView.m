//
//  userDetailView.m
//  KanKeHuDong
//
//  Created by 徐茂怀 on 16/3/22.
//  Copyright © 2016年 kanke. All rights reserved.
//

#import "userDetailView.h"

@implementation userDetailView

-(void)awakeFromNib
{
    _userImage.layer.masksToBounds = YES;
    _userImage.layer.cornerRadius = 50;
    
}

@end
