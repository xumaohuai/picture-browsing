//
//  userDetailView.h
//  KanKeHuDong
//
//  Created by 徐茂怀 on 16/3/22.
//  Copyright © 2016年 kanke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userDetailView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *usernameLab;
@property (strong, nonatomic) IBOutlet UILabel *kankeIDLab;
@property (strong, nonatomic) IBOutlet UIImageView *sexImg;
@property (strong, nonatomic) IBOutlet UIButton *sendMessageBtn;
@property (strong, nonatomic) IBOutlet UIButton *delOrAddBtn;
@property (strong, nonatomic) IBOutlet UILabel *userSchoolLab;
@property (strong, nonatomic) IBOutlet UILabel *userMajorLab;
@property (strong, nonatomic) IBOutlet UIView *userInterstView;

@property (strong, nonatomic) IBOutlet UILabel *userIntroLab;
@end
