//
//  MRMessageArray.m
//  MoRan
//
//  Created by john on 15/9/1.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRMessageArray.h"

@implementation MRMessageArray

- (instancetype)init {
    if (self = [super init]) {
        
        self.messageArray = [[NSMutableArray alloc] init];
        
        for (int i = 1; i <= 2; i++) {
            
            MRMainPublishMessage *message = [[MRMainPublishMessage alloc] init];
            message.locationText = [NSString stringWithFormat:@"第%i行", i];
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int j = 0; j < 5; j++) {
                
                MRImageWithText *imageWithText =[[MRImageWithText alloc] init];
                if (j % 2) imageWithText.text = @"马路对面新开了一家火锅店，看起来还不错的样子。啦啦啦啦是否所发生的";
                else imageWithText.text = @"就看看";
                imageWithText.imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%i", i] ofType:@"png"];
                [array addObject:imageWithText];
            }
            
            message.imageArrayWithText = [[NSArray alloc] initWithArray:array];
            
            [self.messageArray addObject:message];
            
            
        }
    }
    
    return self;
}

- (NSUInteger)count {
    return [self.messageArray count];
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self.messageArray objectAtIndex:index];
}

@end
