//
//  MRRequestModelLogin.h
//  MoRan
//
//  Created by john on 15/9/23.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRRequestModelLogin : NSObject

@property (nonatomic, copy) NSString * email;

@property (nonatomic, copy) NSString * password;

@property (nonatomic, copy) NSString * gbid;

- (instancetype)initWithEmail:(NSString *)email Password:(NSString *)password;

@end
