//
//  MRRequestModelSquareLocationListComment.m
//  MoRan
//
//  Created by john on 10/18/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestModelSquareLocationListComment.h"

@implementation MRRequestModelSquareLocationListComment

- (instancetype)initWithPictureId:(NSString *)picId {
    
    self = [super init];
    
    if (self) {
        
        self.pic_id = picId;
    }
    
    return self;
}

@end
