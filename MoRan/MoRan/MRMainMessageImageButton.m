//
//  MRMainMessageImageButton.m
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRMainMessageImageButton.h"
#import "MRImageWithText.h"
#import "MRPicture.h"


@implementation MRMainMessageImageButton

#pragma mark - Custom Class Methods

- (instancetype)initWithArray:(NSArray *)array IndexPath:(NSIndexPath *)indexPath ArrayNum:(NSInteger)arrayNum {
    
    if (self = [super init]) {
        
        [((MRImageWithText *)[array objectAtIndex:arrayNum]).picture setImageForSender:self Compressed:YES];
        self.cellRow = indexPath.row;
        self.cellSection = indexPath.section;
        self.arrayNum = arrayNum;
        
        [self addTarget:self action:@selector(imageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return self;
}

#pragma mark - DelegateMethod

- (void)imageButtonClicked:(MRMainMessageImageButton *)imageButton {
    if (self._delegate && [(NSObject *)self._delegate respondsToSelector:@selector(imageButtonClicked:)]) {
        [self._delegate imageButtonClicked:self];
    }
}


@end
