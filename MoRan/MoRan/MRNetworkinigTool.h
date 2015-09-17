//
//  MRNetworkinigTool.h
//  MoRan
//
//  Created by john on 15/9/13.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRNetworkinigTool : NSObject

/** get方法发送请求 */
+ (void) get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error)) failure;

/** post方法发送请求 */
+ (void) post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

/** 使用参数类和结果类 get方法发送请求 */
+ (void) getWithUrl:(NSString *)url parameters:(id)parameters resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/** 使用参数类和结果类 post方法发送请求 */
+ (void) postWithUrl:(NSString *)url parameters:(id)parameters resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end