//
//  ImageUtilities.m
//  MoRan
//
//  Created by john on 15/9/23.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "ImageUtilities.h"

@implementation ImageUtilities

+ (CGFloat)heightForImage:(UIImage *)image WhenItsWidth:(CGFloat)width {
    
    UIImageView * view = [[UIImageView alloc] initWithImage:image];
    
    return width * view.frame.size.height / view.frame.size.width;
}

@end
