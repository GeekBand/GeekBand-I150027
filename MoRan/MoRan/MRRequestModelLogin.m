//
//  MRRequestModelLogin.m
//  MoRan
//
//  Created by john on 15/9/23.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRRequestModelLogin.h"
#import "NetworkRequestSetting.h"

@implementation MRRequestModelLogin

- (instancetype)initWithEmail:(NSString *)email Password:(NSString *)password {
    
    if (self = [super init]) {
        
        self.email = email;
        self.password = password;
        self.gbid = MRGBID;
        
    }
    
    return self;
}

@end
