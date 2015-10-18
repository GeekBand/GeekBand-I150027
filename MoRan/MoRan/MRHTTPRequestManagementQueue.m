//
//  MRHTTPRequestManagementQueue.m
//  MoRan
//
//  Created by john on 15/10/5.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRHTTPRequestManagementQueue.h"
#import "MRHTTPRequestOperation.h"
#import "NetworkRequestSetting.h"

//typedef NS_ENUM(NSInteger, MRHTTPResquestManangementQueueType) {
//    
//    MRHTTPResquestManangementQueueTypeNormal         =        MRHTTPRequestStateNormal,
//    MRHTTPResquestManangementQueueTypePaused         =        MRHTTPRequestStatePaused,
//    MRHTTPResquestManangementQueueTypeComplete       =        MRHTTPRequestStateComplete
//};

#define COMPLETE_QUEUE_MAX_LENGTH 10

@interface MRHTTPRequestManagementQueue ()

@property (nonatomic, strong) NSDictionary * queue;


@end

@implementation MRHTTPRequestManagementQueue

- (instancetype)init {

    if (self = [super init]) {
        
//        NSMutableArray * normalQueue = [NSMutableArray new];
//        NSMutableArray * pausedQueue = [NSMutableArray new];
//        NSMutableArray * completeQueue = [NSMutableArray new];
//        
//        
//        self.queue = @{@(MRHTTPResquestManangementQueueTypeNormal):normalQueue, @(MRHTTPResquestManangementQueueTypePaused):pausedQueue, @(MRHTTPResquestManangementQueueTypeComplete):completeQueue};

        
        NSMutableDictionary * dic = [NSMutableDictionary new];
        for (int i = 0; i < finishFlag; i++) {
            
            [dic setObject:[NSMutableArray new] forKey:@(i)];
        }
        
        [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(operationShift) userInfo:nil repeats:YES];
        
    }
    
    return self;
    
}

- (void)addOperation:(MRHTTPRequestOperation *)operation {
    
    [[self.queue objectForKey:@(MRHTTPRequestStateNormal)] addObject:operation];
}

#pragma mark - Get Queues Methods

- (NSMutableArray *)getQueueForState:(MRHTTPRequestState)state {
    
     return [self.queue objectForKey:@(state)];
}


+ (MRHTTPRequestManagementQueue *)sharedQueue {
    
    if (mrHttpRequestManagementSharedQueue == nil) {
        
        mrHttpRequestManagementSharedQueue = [MRHTTPRequestManagementQueue new];
    }
    
    return mrHttpRequestManagementSharedQueue;
}

#pragma mark - Operation Shift Between Queues Methods

- (void)addHTTPRequestOperation:(MRHTTPRequestOperation *)operation ForState:(MRHTTPRequestState)state {
    
    [[self.queue objectForKey:@(state)] addObject:operation];
    
}

- (void)operationShift {
    
    [self.queue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSMutableArray * q = obj;
        for (int i = 0; i < [q count]; i++) {
            
            MRHTTPRequestOperation * op = [q objectAtIndex:i];
            if ([[NSString stringWithFormat:@"%@",key] intValue] != op.state) {
                [q removeObjectAtIndex:i];
                [self addHTTPRequestOperation:op ForState:op.state];
            }
            
            if (op.state == MRHTTPRequestStateComplete) {
                NSMutableArray * array = [self getQueueForState:MRHTTPRequestStateComplete];
                if ([array count] > COMPLETE_QUEUE_MAX_LENGTH) {
                    [array removeObjectAtIndex:0];
                }
            }
        }
    }];
}




@end
