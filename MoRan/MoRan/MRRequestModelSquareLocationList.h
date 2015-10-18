//
//  MRRequestModelSquareLocationList.h
//  MoRan
//
//  Created by john on 10/9/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestModelBase.h"
#import <MAMapKit/MAMapKit.h>

@interface MRRequestModelSquareLocationList : MRRequestModelBase

@property (nonatomic, assign) CGFloat longitude;

@property (nonatomic, assign) CGFloat latitude;

@property (nonatomic, assign) NSInteger distance;

-(instancetype)initWithLongitude:(CGFloat)longitude Latitude:(CGFloat)latitude Distance:(NSInteger)distance;

@end
