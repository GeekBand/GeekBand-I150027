//
//  MRRequestPublish.h
//  MoRan
//
//  Created by john on 10/18/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRRequestPublish : NSObject

+ (void)publishWithImage:(UIImage *)image Longitude:(CGFloat)longitude Latitude:(CGFloat)latitude Address:(NSString *)address Title:(NSString *)title Comment:(NSString *)comment Success:(void (^)())success Failure:(void (^)(NSError * error))failure;

@end
