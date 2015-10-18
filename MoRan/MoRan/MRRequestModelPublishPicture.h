//
//  MRRequestModelPublishPicture.h
//  MoRan
//
//  Created by john on 10/18/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestModelBase.h"

@interface MRRequestModelPublishPicture : MRRequestModelBase

@property (nonatomic, strong) NSNumber * longitude;

@property (nonatomic, strong) NSNumber * latitude;

@property (nonatomic, strong) NSString * addr;

@property (nonatomic, strong) NSString * title;

- (instancetype)initWithLongitude:(CGFloat)longitude Latitude:(CGFloat)latitude Address:(NSString *)addr Title:(NSString *)title;

@end
