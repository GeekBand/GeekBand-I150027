//
//  TextUtilities.h
//  MoRan
//
//  Created by john on 15/8/31.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextUtilities : NSObject


//根据给定字体和宽度计算文本高度
+ (CGFloat)calculateHeightWithText:(NSString *)message TextWidth:(CGFloat)textWidth Font:(UIFont *)font;

@end
