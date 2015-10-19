//
//  MRBaseLocation.m
//  MoRan
//
//  Created by john on 15/9/9.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRBaseLocation.h"

@interface MRBaseLocation ()

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@implementation MRBaseLocation

- (instancetype)initWithLongitude:(CGFloat)longitude Latitude:(CGFloat)latitude {
    
    self = [super init];
    
    if (self) {
        
        self.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
        
    }
    
    return self;
}


@end
