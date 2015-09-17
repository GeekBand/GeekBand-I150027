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







@interface MRMainMessageImageScrollView : UIScrollView


@property(nonatomic, strong)NSMutableArray * imageArray;
@property(nonatomic, strong)NSMutableArray * textArray;
@property(nonatomic, strong)id<MRMainMessageImageButtonDelegate> _delegate;


- (void)setWithImageWithTextArray:(NSArray *)array IndexPath:(NSIndexPath *)indexPath;

@end

