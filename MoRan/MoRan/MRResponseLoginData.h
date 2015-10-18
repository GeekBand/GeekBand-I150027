//
//  MRResponseLogin.h
//  MoRan
//
//  Created by john on 15/9/23.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRResponseLoginData : NSObject

@property (nonatomic, copy) NSString * user_id;

@property (nonatomic, copy) NSString * user_name;

@property (nonatomic, copy) NSString * token;

@property (nonatomic, copy) NSString * avatar;

@property (nonatomic, copy) NSString * project_id;

@property (nonatomic, strong) NSDate * last_login;

@property (nonatomic, assign) NSInteger login_times;


@end
