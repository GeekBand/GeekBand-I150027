//
//  MRSyncRequestBase.m
//  MoRan
//
//  Created by john on 15/9/18.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRSyncRequestBase.h"
#import <MJExtension.h>
#import "BLMultipartForm.h"

@implementation MRSyncRequestBase

- (void)syncPostWithURL:(NSString *)url Parameters:(id)parameters ResponceClass:(Class)responceClass Success:(void (^)(id))success Failure:(void (^)(NSError *))failure
{
    [self.URLConnection cancel];
    
    NSString *URLString = url;
    
    //    // GET  eg, http://xxxx.com/login.json?username=zhangsan&password=123456
    //    URLString = [NSString stringWithFormat:@"%@?username=%@&password=%@", URLString, userName, password];
    //    NSString *encodedURLString
    //    = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSURL *URL = [NSURL URLWithString:encodedURLString];
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    //    request.HTTPMethod = @"GET";
    //    request.timeoutInterval = 60;
    //    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    //    self.URLConnection = [[NSURLConnection alloc] initWithRequest:request
    //                                                         delegate:self
    //                                                 startImmediately:YES];
    
    // POST
    
}



#pragma mark - NSURLConnectionDataDelegate Methods

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {   // 连接成功
        self.receivedData = [NSMutableData data];
    }else {
        // 请求错误，错误处理。
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.success) {
        
        id responce = [self.responceClass objectWithKeyValues:self.receivedData];
        
        self.success(responce);
    }
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.failure) {
        
        self.failure(error);
    }
}



@end
