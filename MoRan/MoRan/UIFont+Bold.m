//
//  UIFont+Bold.m
//  MoRan
//
//  Created by john on 15/9/1.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "UIFont+Bold.h"

@implementation UIFont (Bold)

+ (UIFont *)boldFontWithFont:(UIFont *)font {
    
    UIFontDescriptor * fontD = [font.fontDescriptor
                                fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    return [UIFont fontWithDescriptor:fontD size:0];
}

@end
