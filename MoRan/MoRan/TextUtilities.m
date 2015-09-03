//
//  TextUtilities.m
//  MoRan
//
//  Created by john on 15/8/31.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "TextUtilities.h"

@implementation TextUtilities

+ (CGFloat)calculateHeightWithText:(NSString *)message TextWidth:(CGFloat)textWidth Font:(UIFont *)font {
    
    CGSize textSize = [message boundingRectWithSize:CGSizeMake(textWidth, CGFLOAT_MAX)
                                                  options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName: font, }
                                                  context:nil].size;
    return textSize.height;
}


@end
