//
//  MRBaseLocation.h
//  MoRan
//
//  Created by john on 15/9/9.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

typedef void(^ReGeoHandler)(NSString * address, NSString * title);

@interface MRBaseLocation : NSObject < AMapSearchDelegate >

@property(nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, assign) CGFloat distance;

- (instancetype)initWithLongitude:(CGFloat)longitude Latitude:(CGFloat)latitude;




@end
