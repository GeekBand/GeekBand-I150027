//
//  MRRequestMineSetImage.h
//  MoRan
//
//  Created by john on 10/10/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRRequestMineSetImage : NSObject

+ (void)setImageWithImage:(UIImage *)image Success:(void (^)(id))success Failure:(void (^)(NSError *))failure;

@end
