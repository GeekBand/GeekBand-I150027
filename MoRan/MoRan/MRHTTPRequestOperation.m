//
//  MRHTTPRequestOperation.m
//  MoRan
//
//  Created by john on 15/10/5.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRHTTPRequestOperation.h"

@interface MRHTTPRequestOperation ()




@end

@implementation MRHTTPRequestOperation

- (instancetype)initWithAFHTTPRequestOperation:(AFHTTPRequestOperation *)operation {
    
    if (self = [super init]) {
        
        self.state = MRHTTPRequestStateNormal;
        
        self.operation = operation;
        
        
    }
    
    return self;
}

@end
