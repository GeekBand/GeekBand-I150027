//
//  MRRequestModelSignUp.m
//  MoRan
//
//  Created by john on 15/9/18.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRRequestModelSignUp.h"
#import "NetworkRequestSetting.h"

@implementation MRRequestModelSignUp

- (instancetype)initWithUserName:(NSString *)username PassWord:(NSString *)password Email:(NSString *)email {
    
    if (self = [super init]) {
        
        self.username = username;
//        self.password = password;
//        self.email = email;
        self.gbid = MRGBID;
        self.email = @"helloworld@moran.com";
        self.password = @"a1234567";
    }
    
    return self;
}

@end
