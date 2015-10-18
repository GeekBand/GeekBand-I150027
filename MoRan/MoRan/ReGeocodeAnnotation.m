//
//  ReGeocodeAnnotation.m Referrence to officialDemo2D
//  MoRan
//
//  Created by john on 10/16/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "ReGeocodeAnnotation.h"

@interface ReGeocodeAnnotation ()

//@property (nonatomic, readwrite, strong) AMapReGeocode *reGeocode;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end

@implementation ReGeocodeAnnotation

//- (void)setAMapReGeocode:(AMapReGeocode *)reGerocode
//{
//    self.reGeocode = reGerocode;
//    
//    [self updateContent];
//}

- (void)updateContent
{
    /* 包含 省, 市, 区以及乡镇.  */
//    self.title = [NSString stringWithFormat:@"%@%@%@%@",
//                  self.reGeocode.addressComponent.province?: @"",
//                  self.reGeocode.addressComponent.city ?: @"",
//                  self.reGeocode.addressComponent.district?: @"",
//                  self.reGeocode.addressComponent.township?: @""];
//    
//    /* 包含 社区，建筑. */
//    self.subtitle = [NSString stringWithFormat:@"%@%@",
//                     self.reGeocode.addressComponent.neighborhood?: @"",
//                     self.reGeocode.addressComponent.building?: @""];
}

#pragma mark - Life Cycle

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate Address:(NSString *)address Title:(NSString *)title {
    if (self = [super init])
    {
        self.coordinate = coordinate;
        self.title = title;
        self.subtitle = address;
    }
    
    return self;
}

@end
