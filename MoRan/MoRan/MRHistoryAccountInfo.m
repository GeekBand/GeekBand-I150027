//
//  MRHistoryAccountInfo.m
//  MoRan
//
//  Created by john on 15/9/25.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRHistoryAccountInfo.h"

@implementation MRHistoryAccountInfo

#pragma Custom Class Methods

- (instancetype)initWithEmail:(NSString *)email UserImage:(NSString *)userImage LoginTime:(NSDate *)loginTime {
    
    if (self = [super init]) {
        
        self.email = email;
        self.userImage = userImage;
        self.loginTime = loginTime;
    }
    
    return self;
}

#pragma mark - MJCoding Delegate Methods

MJCodingImplementation

+ (NSArray *)allowedCodingPropertyNames {
    
    return @[@"email", @"userImage", @"loginTime"];
    
}

+ (NSArray *)allowedPropertyNames {
    
    return @[@"email", @"userImage", @"loginTime"];
}


@end
