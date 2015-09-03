//
//  MRImageWithText.h
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRImageWithText : NSObject

@property(nonatomic, copy)NSString * text;
@property(nonatomic, strong)NSString * imagePath;

- (instancetype)initWithImagePath:(NSString *)imagePath Text:(NSString *)text;

@end
