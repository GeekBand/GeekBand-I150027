//
//  MRImageWithText.h
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRUserInfo;

@class MRLocationInfo;

@interface MRImageWithText : NSObject

@property(nonatomic, copy)NSString * text;
@property(nonatomic, strong)NSString * imagePath;
@property(nonatomic, strong)NSDate * publishTime;
@property(nonatomic, strong)MRUserInfo * user;
@property(nonatomic, strong)MRLocationInfo * location;

- (instancetype)initWithImagePath:(NSString *)imagePath Text:(NSString *)text PublishTime:(NSDate *)publishTime User:(MRUserInfo *)user Location:(MRLocationInfo *)location;

@end
