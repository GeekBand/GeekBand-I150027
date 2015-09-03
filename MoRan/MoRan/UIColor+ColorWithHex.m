//
//  UIColor+ColorWithHex.m
//  MoRan
//
//  Created by john on 15/9/1.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "UIColor+ColorWithHex.h"

@implementation UIColor (ColorWithHex)

+ (UIColor *)colorwithHex:(NSInteger)colorHex {
    return [UIColor colorWithRed:(colorHex / 0x10000) / 255.0 green:(colorHex / 0x100 % 0x100) / 255.0 blue:(colorHex % 0x100) / 255.0 alpha:1];
}

@end
