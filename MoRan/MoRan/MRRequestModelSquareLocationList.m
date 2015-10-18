//
//  MRRequestModelSquareLocationList.m
//  MoRan
//
//  Created by john on 10/9/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestModelSquareLocationList.h"

@implementation MRRequestModelSquareLocationList

- (instancetype)initWithLongitude:(CGFloat)longitude Latitude:(CGFloat)latitude Distance:(NSInteger)distance {
    self = [super init];
    
    if (self) {
        self.longitude = longitude;
        self.latitude = latitude;
        self.distance = distance;
    }
    
    return self;
}

@end
