//
//  MRRequestPublish.m
//  MoRan
//
//  Created by john on 10/18/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestPublish.h"
#import "MRNetworkinigTool.h"
#import "MRRequestModelPublishPicture.h"
#import "MRRequestModelPublishComment.h"
#import "MRRequestModelFileDataParameter.h"
#import "NetworkRequestSetting.h"
#import <MJExtension.h>
#import "MRResponsePublishPicture.h"
#import "MRResponsePublishPictureData.h"

@implementation MRRequestPublish

+ (void)publishWithImage:(UIImage *)image Longitude:(CGFloat)longitude Latitude:(CGFloat)latitude Address:(NSString *)address Title:(NSString *)title   Comment:(NSString *)comment Success:(void (^)())success Failure:(void (^)(NSError *))failure {
    
    MRRequestModelFileDataParameter * fileData = [[MRRequestModelFileDataParameter alloc] initWithData:UIImagePNGRepresentation(image) Name:@"publishPicture" FileName:@"image" MimeType:@"image/png"];
    
    NSString * pictureURL = [MRRequestPrefix stringByAppendingString:@"picture/create"];
    
    NSString * commentURL = [MRRequestPrefix stringByAppendingString:@"comment/create"];
    
    [MRNetworkinigTool postWithUrl:pictureURL parameters:[[MRRequestModelPublishPicture alloc] initWithLongitude:longitude Latitude:latitude Address:address Title:title] filesData:@[fileData] resultClass:[MRResponsePublishPicture class] priority:NSQualityOfServiceUserInitiated success:^(MRResponsePublishPicture * responseObject) {
        
        [MRNetworkinigTool postWithUrl:commentURL parameters:[[MRRequestModelPublishComment alloc] initWithPicId:responseObject.data.pic_id Comment:comment] resultClass:nil priority:NSQualityOfServiceUserInitiated success:^(id responseObject){
            
            success();
            
        }failure:failure];
        
    } failure:failure];
    
}

@end
