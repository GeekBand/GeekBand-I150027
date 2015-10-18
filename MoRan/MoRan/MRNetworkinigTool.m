//
//  MRNetworkinigTool.m
//  MoRan
//
//  Created by john on 15/9/13.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRNetworkinigTool.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "UIColor+ColorWithHex.h"
#import "MRHTTPRequestOperation.h"
#import "MRHTTPRequestManagementQueue.h"
#import "MRRequestModelFileDataParameter.h"

@implementation MRNetworkinigTool

#pragma mark - Base API Methods

/** get方法发送请求 */
+ (void) get:(NSString *)url parameters:(NSDictionary *)parameters priority:(NSQualityOfService)priority success:(void (^)(id responseObject))success failure:(void (^)(NSError *error)) failure {
    // 创建http操作管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 发送请求
    MRHTTPRequestOperation * op = [[MRHTTPRequestOperation alloc] initWithAFHTTPRequestOperation:
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        op.state = MRHTTPRequestStateComplete;
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        op.state = MRHTTPRequestStateComplete;
        
        if (failure) {
            failure(error);
        }
    }]];
    

    [op.operation setQualityOfService:priority];
    [[MRHTTPRequestManagementQueue sharedQueue] addOperation:op];
}

/** post方法发送请求 */
+ (void) post:(NSString *)url parameters:(NSDictionary *)parameters priority:(NSQualityOfService)priority success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure {
    // 创建http操作管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 发送请求
    MRHTTPRequestOperation * op = [[MRHTTPRequestOperation alloc] initWithAFHTTPRequestOperation:
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        op.state = MRHTTPRequestStateComplete;
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        op.state = MRHTTPRequestStateComplete;
        
        if (failure) {
            failure(error);
        }
    }]];
    
    
    [op.operation setQualityOfService:priority];
    [[MRHTTPRequestManagementQueue sharedQueue] addOperation:op];
}

+ (void) post:(NSString *)url parameters:(NSDictionary *) parameters priority:(NSQualityOfService)priority filesData:(NSArray *)filesData success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    // 创建http操作管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 发送请求
    MRHTTPRequestOperation * op = [[MRHTTPRequestOperation alloc] initWithAFHTTPRequestOperation:
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 读取文件参数
        for (MRRequestModelFileDataParameter *fileDataParam in filesData) {
            [formData appendPartWithFileData:fileDataParam.data name:fileDataParam.name fileName:fileDataParam.fileName mimeType:fileDataParam.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }]];
    

    [op.operation setQualityOfService:priority];
    [[MRHTTPRequestManagementQueue sharedQueue] addOperation:op];
}

#pragma mark - Request API Methods

/** 使用参数类和结果类 get方法发送请求 */
+ (void) getWithUrl:(NSString *)url parameters:(id)parameters resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 解析出参数
    NSDictionary *param = [parameters keyValues];
    
    [MRNetworkinigTool get:url parameters:param priority:NSQualityOfServiceDefault success:^(id responseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@\n", error);
        
        if (failure) {
            failure(error);
        }
        
        if (error.code == NSURLErrorTimedOut) {
            //请求超时
            NSLog(@"Request Time Out.");
            
            [MRNetworkinigTool showReminderWithString:@"网络不给力，建议切换至其他网络"];
            
            
        } else if (error.code == NSURLErrorNotConnectedToInternet) {
            //没有连网
            NSLog(@"Not connected to internet.");
            
            [MRNetworkinigTool showReminderWithString:@"未连接至网络，请检查网络设置"];
            
        }else {
            
        }
        
        
    }];
}

/** 使用参数类和结果类 post方法发送请求 */
+ (void) postWithUrl:(NSString *)url parameters:(id)parameters resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 解析出参数
    NSDictionary *param = [parameters keyValues];
    
    [MRNetworkinigTool post:url parameters:param priority:NSQualityOfServiceDefault success:^(id responseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@\n", error);
        
        if (failure) {
            failure(error);
        }
        
        if (error.code == NSURLErrorTimedOut) {
            //请求超时
            NSLog(@"Request Time Out.");
            
            [MRNetworkinigTool showReminderWithString:@"网络不给力，建议切换至其他网络"];
            
            
        } else if (error.code == NSURLErrorNotConnectedToInternet) {
            //没有连网
            NSLog(@"Not connected to internet.");
            
            [MRNetworkinigTool showReminderWithString:@"未连接至网络，请检查网络设置"];
            
        }else {
            
        }
        
    }];
}

/** POST请求(带文件参数) */
+ (void) postWithUrl:(NSString *)url parameters:(id)parameters filesData:(NSArray *)filesData resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 解析出参数
    NSDictionary *param = [parameters keyValues];
    
    [MRNetworkinigTool post:url parameters:param priority:NSQualityOfServiceDefault filesData:filesData success:^(id responseObject) {
        if (success) {
            
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@\n", error);
        
        if (failure) {
            failure(error);
        }
        
        if (error.code == NSURLErrorTimedOut) {
            //请求超时
            NSLog(@"Request Time Out.");
            
            [MRNetworkinigTool showReminderWithString:@"网络不给力，建议切换至其他网络"];
            
            
        } else if (error.code == NSURLErrorNotConnectedToInternet) {
            //没有连网
            NSLog(@"Not connected to internet.");
            
            [MRNetworkinigTool showReminderWithString:@"未连接至网络，请检查网络设置"];
            
        }else {
            
        }
    
    }];
}

#pragma mark - Request API With Priority Methods

+ (void) getWithUrl:(NSString *)url parameters:(id)parameters resultClass:(Class)resultClass priority:(NSQualityOfService)priority success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 解析出参数
    NSDictionary *param = [parameters keyValues];
    
    [MRNetworkinigTool get:url parameters:param priority:priority success:^(id responseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@\n", error);
        
        if (failure) {
            failure(error);
        }
        
        if (error.code == NSURLErrorTimedOut) {
            //请求超时
            NSLog(@"Request Time Out.");
            
            [MRNetworkinigTool showReminderWithString:@"网络不给力，建议切换至其他网络"];
            
            
        } else if (error.code == NSURLErrorNotConnectedToInternet) {
            //没有连网
            NSLog(@"Not connected to internet.");
            
            [MRNetworkinigTool showReminderWithString:@"未连接至网络，请检查网络设置"];
            
        }else {
            
        }
        
        
    }];
}

/** 使用参数类和结果类 post方法发送请求 */
+ (void) postWithUrl:(NSString *)url parameters:(id)parameters resultClass:(Class)resultClass priority:(NSQualityOfService)priority success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 解析出参数
    NSDictionary *param = [parameters keyValues];
    
    [MRNetworkinigTool post:url parameters:param priority:priority success:^(id responseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@\n", error);
        
        if (failure) {
            failure(error);
        }
        
        if (error.code == NSURLErrorTimedOut) {
            //请求超时
            NSLog(@"Request Time Out.");
            
            [MRNetworkinigTool showReminderWithString:@"网络不给力，建议切换至其他网络"];
            
            
        } else if (error.code == NSURLErrorNotConnectedToInternet) {
            //没有连网
            NSLog(@"Not connected to internet.");
            
            [MRNetworkinigTool showReminderWithString:@"未连接至网络，请检查网络设置"];
            
        }else {
            
        }
        
    }];
}

/** POST请求(带文件参数) */
+ (void) postWithUrl:(NSString *)url parameters:(id)parameters filesData:(NSArray *)filesData resultClass:(Class)resultClass priority:(NSQualityOfService)priority success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // 解析出参数
    NSDictionary *param = [parameters keyValues];
    
    [MRNetworkinigTool post:url parameters:param priority:priority filesData:filesData success:^(id responseObject) {
        if (success) {
            
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@\n", error);
        
        if (failure) {
            failure(error);
        }
        
        if (error.code == NSURLErrorTimedOut) {
            //请求超时
            NSLog(@"Request Time Out.");
            
            [MRNetworkinigTool showReminderWithString:@"网络不给力，建议切换至其他网络"];
            
            
        } else if (error.code == NSURLErrorNotConnectedToInternet) {
            //没有连网
            NSLog(@"Not connected to internet.");
            
            [MRNetworkinigTool showReminderWithString:@"未连接至网络，请检查网络设置"];
            
        }else {
            
        }
        
    }];
}

#pragma mark - Others

+ (void)handleError:(NSError *)error Handler:(void (^)(NSDictionary *))handler {
#warning Potentially incomplete method implementation.
    
    
    NSData * errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    
    if (errorData == nil) {
        return;
    }
    NSDictionary * serializedData = [NSJSONSerialization JSONObjectWithData:errorData   options:kNilOptions error:nil];
    
    
    if (serializedData[@"message"] != nil) {
        
        NSLog(@"%@",serializedData[@"message"]);
        
        
    }
    
    if (handler) {
        
        handler(serializedData);
    }
    
}

+ (void)showReminderWithString:(NSString *)message {
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    view.autoresizesSubviews = true;
    view.backgroundColor = [UIColor clearColor];
    [view setContentMode:UIViewContentModeCenter];
    
    CGFloat width = 238;
    CGFloat height = 74;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake((view.frame.size.width - width) / 2, (view.frame.size.height - height) / 2, width, height)];
    [label setContentMode:UIViewContentModeCenter];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.numberOfLines = 2;
    
    label.text = message;
    [label setTextColor:[UIColor whiteColor]];
    label.font = [UIFont systemFontOfSize:15.0f];
    
    [label.layer setCornerRadius:5.0f];
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorwithHex:0x444444 Alpha:0.8f];
    
    [view addSubview:label];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissReminderView:)];
    
    [view addGestureRecognizer:tap];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
    
    //2秒后自动移除
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        [MRNetworkinigTool dismissReminderView:tap];
    });
    
}

+ (void)dismissReminderView:(UITapGestureRecognizer *)sender {
    
    [sender.view removeFromSuperview];

}


@end
