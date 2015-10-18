//
//  MRRequestMineChangeName.h
//  MoRan
//
//  Created by john on 10/9/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRRequestMineChangeName : NSObject

+ (void)changeNameWithNewName:(NSString *)name Success:(void (^)(id))success Failure:(void (^)(NSError *))failure;

@end
