//
//  MRUserInfo.m
//  MoRan
//
//  Created by john on 15/9/9.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRBaseUser.h"
#import <MJExtension.h>

@implementation MRBaseUser

MJCodingImplementation

@end


//- (instancetype)initWithUserId:(NSString *)userId UserName:(NSString *)userName UserImage:(NSString *)userImage {
//
//    if (self = [super init]) {
//        self.userId = userId;
//        self.userName = userName;
//        self.userImage = userImage;
//    }
//
//    return self;
//}

//- (NSArray *)keysForEncoding
//{
//    [NSException raise:@"keysForEncoding" format:@"keysForEncoding must be implemented in child class!"];
//
//    //example implementation in child class:
//    //return @[@"airtime", @"channelID", @"duration", @"programID", @"shortTitle"];
//    return nil;
//}
//
//-(void)encodeWithCoder:(NSCoder *)aCoder
//{
//    for(NSString* key in [self keysForEncoding])
//    {
//        [aCoder encodeObject:[self valueForKey:key] forKey:key];
//    }
//}
//
//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super init];
//    if (self) {
//        for (NSString* key in [self keysForEncoding]) {
//            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
//        }
//    }
//    return self;
//}
