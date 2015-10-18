//
//  MRHistoryAccountInfo.h
//  MoRan
//
//  Created by john on 15/9/25.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRBaseUser.h"
#import <MJExtension.h>

@interface MRHistoryAccountInfo : MRBaseUser < MJKeyValue >

@property (nonatomic ,strong) NSDate * loginTime;

- (instancetype)initWithEmail:(NSString *)email UserImage:(NSString *)userImage LoginTime:(NSDate *)loginTime;

@end
