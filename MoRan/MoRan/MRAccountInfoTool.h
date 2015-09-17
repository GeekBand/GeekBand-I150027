//
//  MRAccountInfoTool.h
//  MoRan
//
//  Created by john on 15/9/12.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRAccountInfo.h"

@interface MRAccountInfoTool : NSObject

/** 从文件获取accountInfo */
+ (MRAccountInfo *) getAccountInfo;

/** 存储accountInfo到文件 */
+ (void) saveAccountInfo:(MRAccountInfo *) accountInfo;

@end
