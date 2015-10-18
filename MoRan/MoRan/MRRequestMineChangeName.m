//
//  MRRequestMineChangeName.m
//  MoRan
//
//  Created by john on 10/9/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestMineChangeName.h"
#import "NetworkRequestSetting.h"
#import "MRNetworkinigTool.h"
#import "MRRequestModelMineChangeName.h"

@implementation MRRequestMineChangeName

+ (void)changeNameWithNewName:(NSString *)name Success:(void (^)(id))success Failure:(void (^)(NSError *))failure {
    
    NSString * url = [MRRequestPrefix stringByAppendingString:@"user/rename"];
    
    [MRNetworkinigTool postWithUrl:url parameters:[[MRRequestModelMineChangeName alloc] initWithName:name] resultClass:nil priority:NSQualityOfServiceUserInitiated success:success failure:failure];
}

@end
