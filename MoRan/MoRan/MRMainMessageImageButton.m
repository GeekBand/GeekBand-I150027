//
//  MRMainMessageImageButton.m
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRMainMessageImageButton.h"

@implementation MRMainMessageImageButton

- (instancetype)initWithArray:(NSArray *)array IndexPath:(NSIndexPath *)indexPath ArrayNum:(NSInteger)arrayNum {
    
    if (self = [super init]) {
        [self setImage:[UIImage imageWithContentsOfFile:((MRImageWithText *)[array objectAtIndex:arrayNum]).imagePath] forState:UIControlStateNormal];
        [self setImage:[UIImage imageWithContentsOfFile:((MRImageWithText *)[array objectAtIndex:arrayNum]).imagePath] forState:UIControlStateHighlighted];
        self.cellRow = indexPath.row;
        self.cellSection = indexPath.section;
        self.arrayNum = arrayNum;
    }
    
    
    return self;
}

@end
