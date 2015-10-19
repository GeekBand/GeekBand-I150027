//
//  MRDetailLocation.h
//  MoRan
//
//  Created by john on 10/19/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRBaseLocation.h"

@interface MRDetailLocation : MRBaseLocation


@property(nonatomic, strong, readonly) AMapReGeocode * reGeocode;

- (instancetype)initWithLongitude:(CGFloat)longitude Latitude:(CGFloat)latitude;

- (instancetype)initWithLongitude:(CGFloat)longitude Latitude:(CGFloat)latitude Address:(NSString *)address Title:(NSString *)title;

- (void)getAddressAndTitleWithHandler:(ReGeoHandler)handler;

@end
