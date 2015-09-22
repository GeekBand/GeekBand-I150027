//
//  MRRequestModelSignUp.h
//  MoRan
//
//  Created by john on 15/9/18.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRRequestModelSignUp : NSObject

@property (nonatomic, copy) NSString * username;

@property (nonatomic, copy) NSString * password;

@property (nonatomic, copy) NSString * gbid;

@property (nonatomic, copy) NSString * email;

- (instancetype)initWithUserName:(NSString *)username PassWord:(NSString *)password Email:(NSString *)email;

@end
