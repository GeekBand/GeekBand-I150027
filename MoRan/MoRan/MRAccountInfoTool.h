//
//  MRAccountInfoTool.h
//  MoRan
//
//  Created by john on 15/9/12.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRAccountInfo;
@class MRHistoryAccountInfo;


@interface MRAccountInfoTool : NSObject

/** 从文件获取accountInfo */
+ (MRAccountInfo *) getAccountInfo;

/** 存储accountInfo到文件 */
+ (void) saveAccountInfo:(MRAccountInfo *) accountInfo;

//Log out
+ (void)logout;

//读取历史登录信息
+ (MRHistoryAccountInfo *)getHistoryAccountInfo;

//存储历史登录信息
+ (void)saveHistoryAccountInfo:(MRHistoryAccountInfo *)account;

@end
