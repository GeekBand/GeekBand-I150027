//
//  MRMessageArray.h
//  MoRan
//
//  Created by john on 15/9/1.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRMainPublishMessage.h"
#import "MRImageWithText.h"

@interface MRMessageArray : NSObject

@property(atomic, strong)NSMutableArray * messageArray;

- (NSUInteger)count;

- (id)objectAtIndex:(NSUInteger)index;

- (void)addObject:(nonnull id)object;
@end
