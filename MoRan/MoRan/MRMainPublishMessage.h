//
//  MRMainPublishMessage.h
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRImageWithText.h"
#import "MRDetailLocation.h"

@interface MRMainPublishMessage : NSObject

@property (nonatomic, strong) MRDetailLocation * location;
@property (nonatomic, copy)NSString * locationText;
@property (nonatomic, strong)NSMutableArray * imageArrayWithText;

//- (instancetype)initWithLoctionText:(NSString *)locationText ImageArray:(NSArray *)imageArray TextArray:(NSArray *)textArray;

@end
