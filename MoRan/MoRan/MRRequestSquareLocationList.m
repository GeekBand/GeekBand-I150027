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

//static int locationCount;



@interface MRRequestSquareLocationList ()

@property (atomic, assign) NSInteger locationCount;

@property (nonatomic, assign) Success success;

@property (nonatomic, strong) NSMutableArray * messageArray;

@property (nonatomic, assign) NSInteger locationSum;

@end

@implementation MRRequestSquareLocationList

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.locationCount = 0;
    }
    return self;
}

- (void)locationListRequestWithLocation:(MRBaseLocation *)location Distance:(NSInteger)distance Success:(Success)success Failure:(void (^)(NSError *))failure {
    
    NSString * url = [MRRequestPrefix stringByAppendingString:@"node/list"];
    
    NSString * commentURL = [MRRequestPrefix stringByAppendingString:@"comment"];
    
    self.success = success;
    
    __weak typeof(self) weakSelf = self;
    
    [MRNetworkinigTool get:url parameters:[[[MRRequestModelSquareLocationList alloc] initWithLongitude:location.coordinate.longitude Latitude:location.coordinate.latitude Distance:distance] keyValues] priority:NSQualityOfServiceUserInitiated success:^(id responseObject) {
        
        MRLog(@"Get Location Array");
        
        weakSelf.messageArray = [NSMutableArray new];
        
        if ([[responseObject class] isSubclassOfClass:[NSDictionary class]]) {
            
            id data = [responseObject valueForKey:@"data"];
            if ([[data class] isSubclassOfClass:[NSDictionary class]]) {
                
                self.locationSum = [(NSDictionary *)data count];
                
                //遍历地址列表
                for (id obj in data) {
                    
                    
                    __block MRMainPublishMessage * publishMessage = [MRMainPublishMessage new];
                    [weakSelf.messageArray addObject:publishMessage];
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
                        //图片信息，得到该地点的所有图片和评论
                        id pic = [obj valueForKey:@"pic"];
                        if ([[pic class] isSubclassOfClass:[NSArray class]]) {
                            
                            //node没有提供Title，只能从这里得到了，无语
                            NSArray * picArray = [MRResponseSquareLocationListPicture objectArrayWithKeyValuesArray:pic];
                            
                            title = ((MRResponseSquareLocationListPicture *)picArray[0]).title;
                            
                            publishMessage.location = [[MRDetailLocation alloc] initWithLongitude:longitude Latitude:latitude Address:address Title:title];
                            
                            publishMessage.imageArrayWithText = [NSMutableArray new];
                            
                            __block NSInteger sum = [picArray count];
                            
                            
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
                                    
                                    if (sum == [publishMessage.imageArrayWithText count]) {
                                        
                                        [self locationCountIncrease];
                                    }
                                    
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

- (void)locationCountIncrease {
    
    self.locationCount++;
    
    if (self.locationCount == self.locationSum) {
        
        self.success(self.messageArray);
    }
}


@end
