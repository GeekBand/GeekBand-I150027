//
//  MRRequestSignUp.h
//  MoRan
//
//  Created by john on 15/9/17.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MRRequestModelSignUp;
@class MRResponseSignUp;

@interface MRRequestSignUp : NSObject

+ (void) postWithParameters:(MRRequestModelSignUp *)parameters Success:(void (^)(MRResponseSignUp *))success Failure:(void (^)(NSError *))failure;



@end





