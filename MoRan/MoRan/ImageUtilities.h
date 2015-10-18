//
//  ImageUtilities.h
//  MoRan
//
//  Created by john on 15/9/23.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageUtilities : NSObject


//给定图片宽度，求其不改变原图比例的相应比例高度
+ (CGFloat)heightForImage:(UIImage *)image WhenItsWidth:(CGFloat)width;

@end
