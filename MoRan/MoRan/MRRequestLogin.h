//
//  MRRequestLogin.h
//  MoRan
//
//  Created by john on 15/9/17.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRRequestLogin : NSObject

+ (void)loginWithEmail:(NSString *)email Password:(NSString *)password Success:(void (^)())success Failure:(void (^)(NSError *))failure;

@end
