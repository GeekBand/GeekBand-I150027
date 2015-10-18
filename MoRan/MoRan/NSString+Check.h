//
//  NSString+Check.h
//  MoRan
//
//  Created by john on 15/9/25.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SIGNUP_ERROR_FORMAT_OF_EMAIL @"邮箱格式不正确"
#define SIGNUP_ERROR_FORMAT_OF_EMAIL_EXISTS @"对不起，您的邮箱已被注册过了"
#define SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_NONUMBER @"密码必须包含数字"
#define SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_NOCHAR @"密码必须包含字母"
#define SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_LENGTH @"密码长度必须至少8位"
#define SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_ILLEGEL_CHAR @"密码不得包含初字母和数字以外其他的字符"
#define SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_INCONSISTENCY @"两次输入的密码不同"

@interface NSString (Check)


- (NSString *)isValidAsEmail;

- (NSString *)isValidAsPassword;


@end
