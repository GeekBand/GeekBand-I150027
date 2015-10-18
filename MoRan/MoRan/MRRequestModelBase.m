//
//  MRRequestBase.m
//  MoRan
//
//  Created by john on 15/9/17.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRRequestModelBase.h"
#import "MRAccountInfo.h"
#import "MRAccountInfoTool.h"
#import "MRNetworkinigTool.h"
#import "NetworkRequestSetting.h"
#import "MRRequestModelLogin.h"
#import "MRResponseLogin.h"
#include "MRResponseLoginData.h"

@interface MRRequestModelBase()



@end

@implementation MRRequestModelBase

- (instancetype)init {
    
    if (self = [super init]) {
        
        
        if (isLogin) {
            
            MRAccountInfo * account = [MRAccountInfoTool getAccountInfo];
            
            _token = account.access_token;
            _user_id = account.userId;
            
        } else {
            
#warning Potentially incomplete method implementation.
        }
    }
    
    return self;
}



@end
