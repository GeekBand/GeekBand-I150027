//
//  MRAccountInfoTool.m
//  MoRan
//
//  Created by john on 15/9/12.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRAccountInfoTool.h"
#import "MRAccountInfo.h"
#import "NetworkRequestSetting.h"
#import "BLUtility.h"
#import "MRHistoryAccountInfo.h"

#define accountInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accountInfo.data"]

#define historyAccountInfoPath [BLUtility getPathWithinDocumentDir:@"historyAccount.plist"]

@implementation MRAccountInfoTool

/** 从文件获取accountInfo */
+ (MRAccountInfo *)getAccountInfo {
    MRAccountInfo *accountInfo = mrAccountInfo == nil ? [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:accountInfoPath]] : mrAccountInfo;
    
    // 需要判断是否过期
    if (accountInfo != nil) {
        
        isLogin = true;
        
        NSDate *now = [NSDate date];
        if ([now compare:accountInfo.expires_time] != NSOrderedAscending) { // now->expires_data 非升序, 已经过期
            accountInfo = nil;
            isLogin = false;
        }
    }
    
    return accountInfo;
}

/** 存储accountInfo到文件 */
+ (void)saveAccountInfo:(MRAccountInfo *) accountInfo {
    [NSKeyedArchiver archiveRootObject:accountInfo toFile:accountInfoPath];
    
    mrAccountInfo = nil;
}



+ (void)logout {
    
    [BLUtility removeFile:accountInfoPath];
    
    mrAccountInfo = nil;
    
    isLogin = false;
}

+ (MRHistoryAccountInfo *)getHistoryAccountInfo {
    
    NSString * filePath = historyAccountInfoPath;
    
    NSMutableArray * accountArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    if (accountArray == nil) {
        
        return nil;
    }
    
    [accountArray sortUsingComparator:^NSComparisonResult(NSDictionary * dic1, NSDictionary * dic2) {
       
        return [(NSDate *)(dic1[@"loginTime"]) compare:dic2[@"loginTime"]];
    }];
    
    NSDictionary * dic = [accountArray lastObject];
    
    return [MRHistoryAccountInfo objectWithKeyValues:dic];
    
}

+ (void)saveHistoryAccountInfo:(MRHistoryAccountInfo *)account {
    
    NSString * filePath =  historyAccountInfoPath;
    
    NSMutableArray * accountArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    for (int i = 0; i < [accountArray count]; i++) {
        
        NSDictionary * dic = [accountArray objectAtIndex:i];
        
        if ([dic[@"email"] isEqualToString:account.email]) {
            [accountArray removeObjectAtIndex:i];
            
            [accountArray addObject:account.keyValues];
            
            break;
        }
    }
    
    [accountArray writeToFile:filePath atomically:YES];
}

@end
