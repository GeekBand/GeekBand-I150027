//
//  MRRequestMineGetImage.h
//  MoRan
//
//  Created by john on 10/19/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRRequestBase.h"

typedef void(^FailureBlock)(NSError * error);

@interface MRRequestMineGetImage : MRRequestBase


+ (void)getImageWithUserId:(NSString *)userId Success:(void (^)(id response))success Failure:(FailureBlock)failure;
@end
