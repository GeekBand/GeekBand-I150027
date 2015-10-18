//
//  MRHTTPRequestManagementQueue.h
//  MoRan
//
//  Created by john on 15/10/5.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRHTTPRequestOperation.h"

@interface MRHTTPRequestManagementQueue : NSObject

+ (MRHTTPRequestManagementQueue *)sharedQueue;


//- (void)addHTTPRequestOperation:(MRHTTPRequestOperation *)operation ForState:(MRHTTPRequestState)state;
- (void)addOperation:(MRHTTPRequestOperation *)operation;

@end
