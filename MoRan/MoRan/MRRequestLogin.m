//
//  MRRequestLogin.m
//  MoRan
//
//  Created by john on 15/9/17.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRRequestLogin.h"
#import "MRAccountInfoTool.h"
#import "MRNetworkinigTool.h"
#import "NetworkRequestSetting.h"
#import "MRRequestModelLogin.h"
#import "MRResponseLogin.h"
#import "MRResponseLoginData.h"
#import <MJExtension.h>
#import "MRAccountInfo.h"
#import "MRHistoryAccountInfo.h"
#import "AppDelegate.h"


#import "MRRequestModelSquareLocationList.h"
#import "MRRequestSquareLocationList.h"
#import "MRRequestPublish.h"
#import "MRRequestModelSquareLocationListComment.h"

@implementation MRRequestLogin

+ (void)loginWithEmail:(NSString *)email Password:(NSString *)password Success:(void (^)())success Failure:(void (^)(NSError *))failure{
    
//    [NSThread sleepForTimeInterval:2.0f];
    
    NSString * url = [MRRequestPrefix stringByAppendingString:@"user/login"];
    
    __block NSError * resultError = nil;
    
    [MRNetworkinigTool postWithUrl:url parameters:[[MRRequestModelLogin alloc] initWithEmail:email Password:password] resultClass:[MRResponseLogin class] priority:NSQualityOfServiceUserInitiated success:^(MRResponseLogin *response) {
        
        if (response.status != 1) {
            resultError = [[NSError alloc] initWithDomain:@"login_error" code:400 userInfo:response.keyValues];
            failure(resultError);
            return;
        }
        
        MRAccountInfo * accountInfo = [[MRAccountInfo alloc] init];
        
        accountInfo.userId = response.data.user_id;
        accountInfo.userName = response.data.user_name;
        accountInfo.userImage = response.data.avatar;
        accountInfo.access_token = response.data.token;
        accountInfo.expires_in = [[NSDate alloc] init];
        accountInfo.expires_time = [[NSDate alloc] initWithTimeIntervalSinceNow:MRExpireTime];
        accountInfo.email = email;
        MRLog(@"%@", accountInfo.access_token);
        MRLog(@"%@", accountInfo.userId);
        
        //保存用户信息到文件
        [MRAccountInfoTool saveAccountInfo:accountInfo];
        
        isLogin = true;
        
        //全局变量用户信息赋值
        mrAccountInfo = accountInfo;
        
        //Test
//        MRRequestModelSquareLocationList * model = [[MRRequestModelSquareLocationList alloc] initWithLongitude:120.111111 Latitude:30.111111 Distance:500];
//        [MRNetworkinigTool get:[MRRequestPrefix stringByAppendingString:@"node/list"] parameters:[model keyValues] priority:NSQualityOfServiceDefault success:^(id responseObject) {
//            
//            MRLog(@"%@", responseObject);
//        } failure:^(NSError *error) {
//            
//            [MRNetworkinigTool handleError:error
//                                   Handler:nil];
//            MRLog(@"%@", error);
//        }];
        
//        [MRRequestPublish publishWithImage:[UIImage imageNamed:@"2.png"] Longitude:120.111111 Latitude:30.111111 Address:@"杭州市" Title:@"玉泉校区" Comment:@"hello" Success:^ {
//            
////            MRLog(@"%@", response);
//        } Failure:^(NSError *error) {
//            
//            [MRNetworkinigTool handleError:error
//                                   Handler:nil];
//            MRLog(@"%@", error);
//            
//        }];
        
//        [MRNetworkinigTool get:[MRRequestPrefix stringByAppendingString:@"comment"] parameters:[[[MRRequestModelSquareLocationListComment alloc] initWithPictureId:@"4174"] keyValues] priority:NSQualityOfServiceUserInitiated success:^(id responseObject) {
//            
//            MRLog(@"%@", responseObject);
//                    } failure:^(NSError *error) {
//            
//                        [MRNetworkinigTool handleError:error
//                                               Handler:nil];
//                        MRLog(@"%@", error);
//                        
//                    }];
        
        //保存历史登录记录
        [MRAccountInfoTool saveHistoryAccountInfo:[[MRHistoryAccountInfo alloc] initWithEmail:email UserImage:accountInfo.userImage LoginTime:accountInfo.expires_in]];
        
        if (success) {
            
            success();
        }
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate login];
        
        
    } failure:^(NSError * error){
        
        if (failure) {
            
            failure(error);
        }
    }];
    
}


@end
