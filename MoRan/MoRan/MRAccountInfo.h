//
//  MRAccountInfo.h
//  MoRan
//
//  Created by john on 15/9/13.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRBaseUser.h"


@interface MRAccountInfo : MRBaseUser

/** 访问令牌 */
@property (nonatomic, copy) NSString * access_token;

/** access_token的有效期，单位：秒 */
@property (nonatomic, strong) NSDate * expires_in;

/** 过期时间，自己计算存储 */
@property (nonatomic, strong) NSDate * expires_time;



@end
