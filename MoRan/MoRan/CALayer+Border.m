//
//  CALayer+Border.m
//  MoRan
//
//  Created by john on 15/9/2.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "CALayer+Border.h"

@implementation CALayer (Border)

- (void)setBottomBorderWidth:(CGFloat)width Color:(CGColorRef)color {
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, width);
    bottomBorder.backgroundColor = color;
    [self addSublayer:bottomBorder];
}

- (void)setTopBorderWidth:(CGFloat)width Color:(CGColorRef)color {
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0, 0, self.frame.size.width, width);
    topBorder.backgroundColor = color;
    [self addSublayer:topBorder];
}

@end
