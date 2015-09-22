//
//  MRResponseSignUp.h
//  MoRan
//
//  Created by john on 15/9/18.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRResponseSignUpData;

@interface MRResponseSignUp : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) MRResponseSignUpData * data;

@property (nonatomic, copy) NSString * message;


@end
