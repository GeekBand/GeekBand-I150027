//
//  MRHTTPRequestOperation.h
//  MoRan
//
//  Created by john on 15/10/5.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

//Don't Assign any number to the state, or the queue will go wrong
typedef NS_ENUM(NSInteger, MRHTTPRequestState) {
    
    MRHTTPRequestStateNormal,
    MRHTTPRequestStatePaused,
    MRHTTPRequestStateComplete,

    finishFlag
};

@interface MRHTTPRequestOperation : NSObject

@property (nonatomic, assign) MRHTTPRequestState state;

@property (nonatomic, strong) AFHTTPRequestOperation * operation;

- (instancetype)initWithAFHTTPRequestOperation:(AFHTTPRequestOperation *)operation;

@end
