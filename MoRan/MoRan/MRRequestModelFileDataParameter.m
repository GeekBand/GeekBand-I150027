//
//  MRRequestModelFileDataParameter.m
//  MoRan
//
//  Created by john on 10/10/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestModelFileDataParameter.h"

@implementation MRRequestModelFileDataParameter

- (instancetype)initWithData:(NSData *)data Name:(NSString *)name FileName:(NSString *)fileName MimeType:(NSString *)mineType {
    
    self = [super init];
    
    if (self) {
        
        self.data = data;
        self.name = name;
        self.fileName = fileName;
        self.mimeType = mineType;
    }
    
    return self;
}

@end
