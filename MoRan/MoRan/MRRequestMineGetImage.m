//
//  MRRequestMineGetImage.m
//  MoRan
//
//  Created by john on 10/19/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestMineGetImage.h"
#import "MRNetworkinigTool.h"
#import "NetworkRequestSetting.h"
#import "MRRequestModelMineGetImage.h"

@implementation MRRequestMineGetImage

+ (void)getImageWithUserId:(NSString *)userId Success:(void (^)(id))success Failure:(FailureBlock)failure {
    
    NSString * url = [MRRequestPrefix stringByAppendingString:@"user/show"];
    
    [MRNetworkinigTool get:url
                parameters:[[[MRRequestModelMineGetImage alloc] initWithUserId:userId] keyValues]
                  priority:NSQualityOfServiceDefault
                   success:success
                   failure:failure];
}

@end
