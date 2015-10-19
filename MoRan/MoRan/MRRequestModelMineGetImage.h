//
//  MRRequestModelMineGetImage.h
//  MoRan
//
//  Created by john on 10/19/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRRequestModelMineGetImage : NSObject

@property (nonatomic, strong) NSString * user_id;

-(instancetype)initWithUserId:(NSString *)userId;

@end
