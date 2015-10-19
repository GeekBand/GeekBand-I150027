//
//  MRImageWithText.h
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRBaseUser.h"

@class MRDetailLocation;

@class MRPicture;

@interface MRImageWithText : NSObject

@property(nonatomic, copy)NSString * text;
@property(nonatomic, strong)MRPicture * picture;
@property(nonatomic, strong)NSDate * publishTime;
@property(nonatomic, strong)MRBaseUser * user;
@property(nonatomic, strong)MRDetailLocation * location;

- (instancetype)initWithPicture:(MRPicture *)picture Text:(NSString *)text PublishTime:(NSDate *)publishTime User:(MRBaseUser *)user Location:(MRDetailLocation *)location;

@end
