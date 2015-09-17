//
//  MRAccountInfoTool.m
//  MoRan
//
//  Created by john on 15/9/12.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRAccountInfoTool.h"

#define accountInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accountInfo.data"]

@implementation MRAccountInfoTool

/** 从文件获取accountInfo */
+ (MRAccountInfo *)getAccountInfo {
    MRAccountInfo *accountInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:accountInfoPath]];
    
    // 需要判断是否过期
    NSDate *now = [NSDate date];
    if ([now compare:accountInfo.expires_time] != NSOrderedAscending) { // now->expires_data 非升序, 已经过期
        accountInfo = nil;
    }
    
    return accountInfo;
}

/** 存储accountInfo到文件 */
+ (void) saveAccountInfo:(MRAccountInfo *) accountInfo {
    [NSKeyedArchiver archiveRootObject:accountInfo toFile:accountInfoPath];
}

@end
