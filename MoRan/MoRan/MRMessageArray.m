//
//  MRMessageArray.m
//  MoRan
//
//  Created by john on 15/9/1.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRMessageArray.h"
#import "MRBaseLocation.h"
#import "MRRequestSquareLocationList.h"

@interface MRMessageArray ()

@property(nonatomic, strong) NSMutableArray * messageArray;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, assign) NSInteger distance;

@end

@implementation MRMessageArray

- (instancetype)init {
    if (self = [super init]) {
        
        self.messageArray = [[NSMutableArray alloc] init];
        
        self.coordinate = CLLocationCoordinate2DMake(90, 0);
        
        self.distance = 0;
        
//        for (int i = 1; i <= 5; i++) {
//            
//            MRMainPublishMessage *message = [[MRMainPublishMessage alloc] init];
//            message.locationText = [NSString stringWithFormat:@"第%i行", i];
//            
//            NSMutableArray *array = [[NSMutableArray alloc] init];
//            for (int j = 0; j < 5; j++) {
//                
//                MRImageWithText *imageWithText =[[MRImageWithText alloc] init];
//                if (j % 2) imageWithText.text = @"马路对面新开了一家火锅店，看起来还不错的样子。啦啦啦啦是否所发生的";
//                else imageWithText.text = @"就看看";
//                imageWithText.imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%i", i % 2 + 1] ofType:@"png"];
//                [array addObject:imageWithText];
//            }
//            
//            message.imageArrayWithText = [[NSArray alloc] initWithArray:array];
//            
//            [self.messageArray addObject:message];
//            
//            
//        }
    }
    
    return self;
}

- (void)refreshWithLocation:(MRBaseLocation *)location Distance:(NSInteger)distance Complete:(void (^)(NSError * error))handler {
    
    if (distance != self.distance || MAMetersBetweenMapPoints(MAMapPointForCoordinate(location.coordinate), MAMapPointForCoordinate(self.coordinate)) > 10) {
        
        MRRequestSquareLocationList * request = [[MRRequestSquareLocationList alloc] init];
        
        [request locationListRequestWithLocation:location Distance:distance Success:^(NSMutableArray *array) {
            
            self.messageArray = array;
            
            self.distance = distance;
            
            self.coordinate = location.coordinate;
            
            handler(nil);
            
        } Failure:^(NSError * error) {
            
            handler(error);
        }];
        
    } else {
        
        handler(nil);
    }
    
    
    
}

- (NSUInteger)count {
    return [self.messageArray count];
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self.messageArray objectAtIndex:index];
}

- (void)addObject:(nonnull id)object{
    
    [self.messageArray addObject:object];
}

@end
