//
//  MRMainMessageImageButton.h
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRImageWithText.h"



@interface MRMainMessageImageButton : UIButton


@property(nonatomic, assign)NSInteger cellRow;
@property(nonatomic, assign)NSInteger cellSection;
@property(nonatomic, assign)NSInteger arrayNum;

- (instancetype)initWithArray:(NSArray *)array IndexPath:(NSIndexPath *)indexPath ArrayNum:(NSInteger)arrayNum;

@end
