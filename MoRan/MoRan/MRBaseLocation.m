//
//  MRBaseLocation.m
//  MoRan
//
//  Created by john on 15/9/9.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRBaseLocation.h"

@interface MRBaseLocation ()

@property(nonatomic, strong) AMapSearchAPI * search;

@property(nonatomic, strong) AMapReGeocode * reGeocode;

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

@property(nonatomic, assign) ReGeoHandler handler;

@property(nonatomic, copy) NSString * address;

@property(nonatomic, copy) NSString * title;


@end

@implementation MRBaseLocation

- (instancetype)initWithLongitude:(CGFloat)longitude Latitude:(CGFloat)latitude {
    
    self = [super init];
    
    if (self) {
        
        self.coordinate = CLLocationCoordinate2DMake(longitude, latitude);
        
        [self searchReGeocodeWithCoordinate:self.coordinate];
        
        
    }
    
    return self;
}

- (instancetype)initWithLongitude:(CGFloat)longitude Latitude:(CGFloat)latitude Address:(NSString *)address Title:(NSString *)title {
    
    self = [super init];
    
    if (self) {
        
        self.coordinate = CLLocationCoordinate2DMake(longitude, latitude);
        
        self.address = address;
        
        self.title = title;
        
        
    }
    
    return self;
}

- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate {
    
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension            = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
    
}

- (void)handleReGeo {
    
    if (self.handler && self.reGeocode) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            self.handler(self.address, self.title);
            
            self.handler = nil;
        });
        
    }
}

- (void)getAddressAndTitleWithHandler:(ReGeoHandler)handler {
    
    if (self.address && self.title) {
        
        handler(self.address, self.title);
    } else {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            @synchronized(self) {
                
                self.handler = handler;
                [self handleReGeo];
                
            }
        });
        
        
    }
}

+ (NSString *)getAddress:(AMapReGeocode *)reGeoCode {
    
    return @"";
}

+ (NSString *)getTitle:(AMapReGeocode *)reGeoCode {
    
    return @"";
}

#pragma mark - AMapSearchDelegate

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    
    if (response.regeocode != nil) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            @synchronized(self) {
                
                self.address = [MRBaseLocation getAddress:response.regeocode];
                
                self.title = [MRBaseLocation getAddress:response.regeocode];
                
                self.reGeocode = response.regeocode;
                
                [self handleReGeo];
            }
        });
    }
}


@end
