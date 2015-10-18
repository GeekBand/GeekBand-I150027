//
//  ReGeocodeAnnotation.h Referrence to officialDemo2D
//  MoRan
//
//  Created by john on 10/16/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapCommonObj.h>

@interface ReGeocodeAnnotation : NSObject <MAAnnotation>

//- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate reGeocode:(AMapReGeocode *)reGeocode;
//
//@property (nonatomic, readonly, strong) AMapReGeocode *reGeocode;
//- (void)setAMapReGeocode:(AMapReGeocode *)reGerocode;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate Address:(NSString *)address Title:(NSString *)title;



@end