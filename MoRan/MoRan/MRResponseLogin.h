//
//  MRResponseLogin.h
//  MoRan
//
//  Created by john on 15/9/24.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRResponseLoginData;

@interface MRResponseLogin : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) MRResponseLoginData * data;

@property (nonatomic, copy) NSString * message;

@end
