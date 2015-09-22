//
//  MRSyncRequestBase.h
//  MoRan
//
//  Created by john on 15/9/18.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(id);
typedef void(^Failure)(NSError *);

__attribute__((deprecated))
@interface MRSyncRequestBase : NSObject <NSURLConnectionDataDelegate>



@property(nonatomic, strong)NSURLConnection *URLConnection;
@property(nonatomic, strong)NSMutableData *receivedData;
@property (nonatomic, copy) Success success;
@property (nonatomic, copy) Failure failure;
@property (nonatomic, assign) Class responceClass;


+ (void)syncPostWithURL:(NSString *)url Parameters:(id)parameters ResponceClass:(Class)responceClass Success:(void (^)(id))success Failure:(void (^)(NSError *))failure;


@end
