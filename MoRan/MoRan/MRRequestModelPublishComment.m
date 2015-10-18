//
//  MRRequestModelPublishComment.m
//  MoRan
//
//  Created by john on 10/18/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestModelPublishComment.h"

@implementation MRRequestModelPublishComment

- (instancetype)initWithPicId:(NSString *)picId Comment:(NSString *)comment {
    
    self = [super init];
    
    if (self) {
        
        self.pic_id = picId;
        
        self.comment = comment;
    }
    
    return self;
}

@end
