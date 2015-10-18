//
//  MRRequestModelPublishPicture.m
//  MoRan
//
//  Created by john on 10/18/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestModelPublishPicture.h"

@implementation MRRequestModelPublishPicture

- (instancetype)initWithLongitude:(CGFloat)longitude Latitude:(CGFloat)latitude Address:(NSString *)addr Title:(NSString *)title {
    
    self = [super init];
    
    if (self) {
        
        self.longitude = [NSNumber numberWithFloat:longitude];
        self.latitude = [NSNumber numberWithFloat:latitude];
        self.addr = addr;
        self.title = title;
    }
    
    return self;
}

@end
