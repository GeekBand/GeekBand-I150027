//
//  MRMainMessageImageScrollView.h
//  MoRan
//
//  Created by john on 15/8/31.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRImageWithText.h"
#import "MainviewSetting.h"
#import "MRMainMessageImageButton.h"
#import "TextUtilities.h"
#import "MRMainPublishMessage.h"
#import "UIColor+ColorWithHex.h"

@class MRMainMessageImageScrollView;

@interface MRMainMessageImageScrollView : UIScrollView


@property(nonatomic, strong)NSArray * imageWithTextArray;


- (void)setWithImageWithTextArray:(NSArray *)array IndexPath:(NSIndexPath *)indexPath;

@end

@protocol MRMainMessageImageScrollViewDelegate <NSObject>

@required
- (void)imageButtonClicked:(MRMainMessageImageButton *)button;

@end