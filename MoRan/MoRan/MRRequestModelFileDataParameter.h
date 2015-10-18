//
//  MRRequestModelFileDataParameter.h
//  MoRan
//
//  Created by john on 10/10/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRRequestModelFileDataParameter : NSObject

@property (nonatomic, strong) NSData * data;

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * fileName;

@property (nonatomic, copy) NSString * mimeType;

- (instancetype)initWithData:(NSData *)data Name:(NSString *)name FileName:(NSString *)fileName MimeType:(NSString *)mineType;

@end
