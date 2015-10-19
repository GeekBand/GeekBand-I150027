//
//  MoRanTests.m
//  MoRanTests
//
//  Created by john on 15/8/19.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>



@interface MoRanTests : XCTestCase

@end

@implementation MoRanTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    
//    typedef NS_ENUM(NSInteger, MRHTTPResquestManangementQueueType) {
//        
//        MRHTTPResquestManangementQueueTypeNormal         =        2,
//        MRHTTPResquestManangementQueueTypePaused         =        1,
//        MRHTTPResquestManangementQueueTypeComplete       =        0,
//        last
//    };
    
//    NSMutableArray * normalQueue = [NSMutableArray new];
//    NSMutableArray * pausedQueue = [NSMutableArray new];
//    NSMutableArray * completeQueue = [NSMutableArray new];
//    
//    [normalQueue addObject:@"he"];
//    NSDictionary * queue = @{@(MRHTTPResquestManangementQueueTypeNormal):normalQueue, @(MRHTTPResquestManangementQueueTypePaused):pausedQueue, @(MRHTTPResquestManangementQueueTypeComplete):completeQueue};
//    
////    NSLog(@"%@", [queue objectForKey:@(MRHTTPResquestManangementQueueTypeNormal)]);
//    
//    [queue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
////        NSLog(@"%@", key);
////        NSLog(@"%@", [key class]);
//        NSLog(@"%i", key );
//    }];

//    NSLog(@"%li", (long)last);
//    MRRequestModelSquareLocationList * model = [[MRRequestModelSquareLocationList alloc] initWithLongtitude:0 Latitude:0 Distance:1000];
//    model.user_id = @"27";
//    model.token = @"e9a6e1a194d40bc9e98c14e92717c546d19c3991";
//    
//    [MRNetworkinigTool get:[MRRequestPrefix stringByAppendingString:@"node/list"] parameters:[model keyValues] priority:NSQualityOfServiceUserInitiated success:<#^(id responseObject)success#> failure:<#^(NSError *error)failure#>]
    
    
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
