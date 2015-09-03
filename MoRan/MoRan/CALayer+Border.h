//
//  CALayer+Border.h
//  MoRan
//
//  Created by john on 15/9/2.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Border)

//添加下内边线
- (void)setBottomBorderWidth:(CGFloat)width Color:(CGColorRef)color;
//添加上内边线
- (void)setTopBorderWidth:(CGFloat)width Color:(CGColorRef)color;

@end
