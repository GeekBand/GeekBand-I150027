//
//  NetworkRequestSetting.h
//  MoRan
//
//  Created by john on 15/9/18.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRAccountInfo;
@class MRHTTPRequestManagementQueue;

extern NSString * const MRRequestPrefix;
extern NSString * const MRGBID;
extern CGFloat const MRExpireTime;
extern MRAccountInfo * mrAccountInfo;
extern BOOL isLogin;

extern MRHTTPRequestManagementQueue * mrHttpRequestManagementSharedQueue;

extern NSString * const APIKEY;