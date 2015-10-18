//
//  MRImageWithText.m
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRImageWithText.h"

@implementation MRImageWithText

- (instancetype)initWithPicture:(MRPicture *)picture Text:(NSString *)text PublishTime:(NSDate *)publishTime User:(MRBaseUser *)user Location:(MRBaseLocation *)location{
    if (self = [super init]) {
        self.text = text;
        self.picture = picture;
        self.publishTime = publishTime;
        self.user = user;
        self.location = location;
    }
    
    return self;
}

@end
