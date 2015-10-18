//
//  NSString+Check.m
//  MoRan
//
//  Created by john on 15/9/25.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "NSString+Check.h"


@implementation NSString (Check)

- (NSString *)isValidAsEmail {
    
    NSRange r = [self rangeOfString:@"@"];
    if (r.location == NSNotFound) {
        
        return SIGNUP_ERROR_FORMAT_OF_EMAIL;
    }
    
    return nil;
    
}

- (NSString *)isValidAsPassword {
    
    NSCharacterSet * cSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"];
    NSCharacterSet * nSet = [NSCharacterSet decimalDigitCharacterSet];
    
    NSString * password = self;
    
    if ([password length] < 8) {
        return SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_LENGTH;
    }
    
    BOOL hasNumber = false;
    BOOL hasLetter = false;
    for (int i = 0; i < [password length]; i++) {
        
        unichar c = [password characterAtIndex:i];
        
        if ([cSet characterIsMember:c] == false) {
            return SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_ILLEGEL_CHAR;
        } else if ([nSet characterIsMember:c]) {
            hasNumber = true;
        } else {
            hasLetter = true;
        }
    }
    
    if (!hasNumber) {
        return SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_NONUMBER;
    }
    
    if (!hasLetter) {
        return SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_NOCHAR;
    }
    
    return nil;
    
}

@end
