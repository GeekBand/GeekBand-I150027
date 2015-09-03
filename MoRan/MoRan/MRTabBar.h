//
//  MRTabBar.h
//  MoRan
//
//  Created by john on 15/8/23.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextUtilities.h"
#import "MainviewSetting.h"
#import "UIFont+Bold.h"
#import "UIColor+ColorWithHex.h"



@class MRTabBar;

@protocol MRTabBarDelegate <UITabBarDelegate>

@required
- (void)publishButtonClicked:(UIButton *)publishButton;

@end


@interface MRTabBar : UITabBar

- (void)initTextAttribute;

- (void)initButtonAttribute;

- (void)addComposeButton;


@end
