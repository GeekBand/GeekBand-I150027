//
//  MRRequestSquareLocationList.m
//  MoRan
//
//  Created by john on 10/13/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestSquareLocationList.h"
#import "MRBaseLocation.h"
#import "NetworkRequestSetting.h"
#import "MRNetworkinigTool.h"
#import "MRRequestModelSquareLocationList.h"
#import <MJExtension.h>
#import "MRResponseSquareLocationListPicture.h"
#import "MRMessageArray.h"
#import "MRMainPublishMessage.h"
#import "MRPicture.h"
#import "MRRequestModelSquareLocationListComment.h"
#import "MRResponseSquareLocationListComment.h"
#import "MRResponseSquareLocationListCommentData.h"

@implementation MRRequestSquareLocationList

+ (void)locationListRequestWithLocation:(MRBaseLocation *)location Distance:(NSInteger)distance Success:(void (^)(id))success Failure:(void (^)(NSError *))failure {
    
    NSString * url = [MRRequestPrefix stringByAppendingString:@"node/list"];
    
    NSString * commentURL = [MRRequestPrefix stringByAppendingString:@"comment"];
    
    [MRNetworkinigTool get:url parameters:[[[MRRequestModelSquareLocationList alloc] initWithLongitude:location.coordinate.longitude Latitude:location.coordinate.latitude Distance:distance] keyValues] priority:NSQualityOfServiceUserInitiated success:^(id responseObject) {
        
        MRMessageArray * messageArray = [MRMessageArray new];
        
        if ([[responseObject class] isSubclassOfClass:[NSDictionary class]]) {
            
            id data = [responseObject valueForKey:@"data"];
            if ([[data class] isSubclassOfClass:[NSDictionary class]]) {
                
                //遍历地址列表
                for (id obj in data) {
                    
                    __block MRMainPublishMessage * publishMessage = [MRMainPublishMessage new];
                    [messageArray addObject:publishMessage];
                    CGFloat longitude = 0.0;
                    CGFloat latitude = 0.0;
                    NSString * address = nil;
                    CGFloat dis = 0;
                    NSString * title = nil;
                    
                    if ([[obj class] isSubclassOfClass:[NSDictionary class]]) {
                        
                        //地点信息
                        id node = [obj valueForKey:@"node"];
                        if ([[node class] isSubclassOfClass:[NSDictionary class]]) {
                            id geo = [node objectForKey:@"ST_AsText(geom)"];
                            if ([[geo class] isSubclassOfClass:[NSString class]]) {
                                NSString * locationString = geo;
                                locationString = [locationString substringFromIndex:6];
                                NSArray * subStrings = [locationString componentsSeparatedByString:@" "];
                                
                                longitude = [subStrings[0] floatValue];
                                latitude = [[subStrings[1] substringToIndex:[subStrings[1] length] - 1] floatValue];
                                
                            }
                            id addr = [node valueForKey:@"addr"];
                            if ([[addr class] isSubclassOfClass:[NSString class]]) {
                                
                                address = addr;
                            }
                            
                            id distance = [node valueForKey:@"distance_in_meters"];
                            if ([[distance class] isSubclassOfClass:[NSString class]]) {
                                
                                dis = [(NSString *)distance floatValue];
                            }
                        }
                        //图片信息
                        id pic = [obj valueForKey:@"pic"];
                        if ([[pic class] isSubclassOfClass:[NSArray class]]) {
                            
                            //没有提供Title，只能从这里得到了，无语
                            NSArray * picArray = [MRResponseSquareLocationListPicture objectArrayWithKeyValuesArray:pic];
                            
                            title = ((MRResponseSquareLocationListPicture *)picArray[0]).title;
                            
                            publishMessage.location = [[MRBaseLocation alloc] initWithLongitude:longitude Latitude:latitude Address:address Title:title];
                            
                            publishMessage.imageArrayWithText = [NSMutableArray new];
                            
                            
                            //对每个图片发送评论请求
                            for (MRResponseSquareLocationListPicture * response in picArray) {
                                
                                [MRNetworkinigTool getWithUrl:commentURL parameters:[[MRRequestModelSquareLocationListComment alloc] initWithPictureId:response.picture_id] resultClass:[MRResponseSquareLocationListComment class] priority:NSQualityOfServiceUserInitiated success:^(MRResponseSquareLocationListComment * commentResponse) {
                                    
                                    //没有对评论进行处理，只取第一条
                                    MRResponseSquareLocationListCommentData* commentData = [commentResponse.data objectAtIndex:0];
                                    
                                    NSDateFormatter * format = [NSDateFormatter new];
                                    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                                    NSDate * date = [format dateFromString:commentData.created];
                                    
                                    MRBaseUser * user = [MRBaseUser new];
                                    user.userId = commentData.user_id;
                                    
                                    MRImageWithText * imageWithText =
                                    [[MRImageWithText alloc] initWithPicture:[[MRPicture alloc] initWithURLofCompressedImage:nil NormalImage:response.pic_link]
                                                                        Text:commentData.comment
                                                                 PublishTime:date
                                                                        User:user
                                                                    Location:publishMessage.location];
                                    
                                    [publishMessage.imageArrayWithText addObject:imageWithText];
                                    
                                } failure:failure];
                                
                            }
                        }
                    }
                }
            }
            
        }
        
    }
                   failure:failure];

}



@end
