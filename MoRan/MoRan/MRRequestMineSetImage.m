//
//  MRRequestMineSetImage.m
//  MoRan
//
//  Created by john on 10/10/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestMineSetImage.h"
#import "MRNetworkinigTool.h"
#import "MRRequestModelFileDataParameter.h"
#import "NetworkRequestSetting.h"
#import "MRRequestModelBase.h"

@implementation MRRequestMineSetImage

+ (void)setImageWithImage:(UIImage *)image Success:(void (^)(id))success Failure:(void (^)(NSError *))failure {
    
    MRRequestModelFileDataParameter * fileData = [[MRRequestModelFileDataParameter alloc] initWithData:UIImagePNGRepresentation(image) Name:@"userImage" FileName:@"image" MimeType:@"image/png"];
    
    NSString * url = [MRRequestPrefix stringByAppendingString:@"user/avatar"];
    
    [MRNetworkinigTool postWithUrl:url parameters:[[MRRequestModelBase alloc] init] filesData:@[fileData] resultClass:nil priority:NSQualityOfServiceUserInitiated success:success failure:failure];
}

@end
