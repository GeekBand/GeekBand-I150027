//
//  MRRequestSignUp.m
//  MoRan
//
//  Created by john on 15/9/17.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRRequestSignUp.h"
#import "MRNetworkinigTool.h"
#import "NetworkRequestSetting.h"
#import "MRResponseSignUp.h"

@implementation MRRequestSignUp

+ (void)postWithParameters:(MRRequestModelSignUp *)parameters Success:(void (^)(MRResponseSignUp *))success Failure:(void (^)(NSError *))failure {
    
    NSString * url = [MRRequestPrefix stringByAppendingString:@"user/register"];
    
    [MRNetworkinigTool postWithUrl:url parameters:parameters resultClass:[MRResponseSignUp class] success:success failure:failure];
}

@end
