//
//  MRTabBar.m
//  MoRan
//
//  Created by john on 15/8/23.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRTabBar.h"
#import "MainviewSetting.h"

@implementation MRTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //设置字体及其颜色和大小
    [self initTextAttribute];
    
    //设置按键图片大小和位置
    [self initButtonAttribute];
    
    //增加发布键
    [self addComposeButton];
}

- (void)initTextAttribute {
    
    //初始化字体属性
    NSMutableDictionary *attrForSelected = [NSMutableDictionary dictionary];
    attrForSelected[NSForegroundColorAttributeName] = [UIColor colorwithHex:0xee7f41];
    attrForSelected[NSFontAttributeName] = [UIFont boldFontWithFont:[UIFont fontWithName:MRTabBarFont size:MRTabBarFontSize]];
    
    NSMutableDictionary *attrForUnselected = [NSMutableDictionary dictionary];
    attrForUnselected[NSBackgroundColorAttributeName] = [UIColor colorwithHex:0xa8a8a9];
    attrForUnselected[NSFontAttributeName] = [UIFont boldFontWithFont:[UIFont fontWithName:MRTabBarFont size:MRTabBarFontSize]];

    
    for (UITabBarItem *item in self.items) {
        [item setTitleTextAttributes:attrForSelected forState:UIControlStateSelected];
        [item setTitleTextAttributes:attrForUnselected forState:UIControlStateNormal];
        [item setTitlePositionAdjustment:UIOffsetMake(0, - MRTabBarFontSize / 2)];
    }
    
    
}

- (void)initButtonAttribute {
    
    BOOL tag = true ;
    
    for (UIView * tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIView * tabBarImage in tabBarButton.subviews) {
                if ([tabBarImage isKindOfClass:NSClassFromString(@"UIImageView")]) {
                    CGRect imageFrame = tabBarImage.frame;
                    
                    imageFrame.origin.y = imageFrame.origin.y - MRTabBarHeight + imageFrame.size.height;
                    imageFrame.size.height = MRTabBarImageHeight;
                
                    tabBarImage.frame = imageFrame;
                }
                
            }
            CGRect barFrame = tabBarButton.frame;
            barFrame.size.width = (self.frame.size.width - MRPublishButtonWidth) / 2;
            
            if (tag) {
                tag = !tag;
            } else {
                barFrame.origin.x = barFrame.origin.x + MRPublishButtonWidth / 2;
            }
            
        }
    }
    
}

- (void)addComposeButton {
    UIButton * publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [publishButton.layer setCornerRadius:22.5];
    [publishButton.layer setBorderWidth:1.0f];
    [publishButton.layer setBorderColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"publish"]]CGColor]];
     
    [publishButton setClipsToBounds:true];
    [publishButton setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    [publishButton setImage:[UIImage imageNamed:@"publish_hover"] forState:UIControlStateHighlighted];
    
    CGFloat width = MRPublishButtonWidth;
    CGFloat height = MRPublishButtonHeight;
    CGFloat x = self.frame.size.width / 2 - MRPublishButtonWidth / 2;
    CGFloat y = - MRPublishButtonWidth / 2;
    publishButton.frame = CGRectMake(x, y, width, height);
    
    [publishButton addTarget:self
                        action:@selector(publishButtonClicked:)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:publishButton];
}

//-(CGSize)sizeThatFits:(CGSize)size
//{
//    CGSize sizeThatFits = [super sizeThatFits:size];
//    sizeThatFits.height = MRTabBarHeight;
//    
//    return sizeThatFits;
//}


#pragma mark DelegateMethod

@end
