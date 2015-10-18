//
//  NetworkRequestSetting.m
//  MoRan
//
//  Created by john on 15/9/18.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "NetworkRequestSetting.h"



//注册与登录
NSString * const MRRequestPrefix = @"http://moran.chinacloudapp.cn/moran/web/";
NSString * const MRGBID = @"GeekBand-I150027";
CGFloat const MRExpireTime = 7 * 24 * 60 * 60;

//账户信息
MRAccountInfo * mrAccountInfo = nil;
BOOL isLogin = false;


MRHTTPRequestManagementQueue *  mrHttpRequestManagementSharedQueue= nil;

NSString * const APIKEY = @"35c50e3a3a387a764488bed16608472b";