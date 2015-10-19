//
//  MRRequestModelMineGetImage.m
//  MoRan
//
//  Created by john on 10/19/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestModelMineGetImage.h"

@implementation MRRequestModelMineGetImage

- (instancetype)initWithUserId:(NSString *)userId
{
    self = [super init];
    if (self) {
        
        self.user_id = userId;
    }
    return self;
}

@end
