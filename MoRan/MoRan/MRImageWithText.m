//
//  MRImageWithText.m
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRImageWithText.h"

@implementation MRImageWithText

- (instancetype)initWithImagePath:(NSString *)imagePath Text:(NSString *)text {
    if (self = [super init]) {
        self.text = text;
        self.imagePath = imagePath;
    }
    
    return self;
}

@end
