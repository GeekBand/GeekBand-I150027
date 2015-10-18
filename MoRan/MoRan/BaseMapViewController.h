//
//  BaseMapViewController.h Referrence to officialDemo2D
//  MoRan
//
//  Created by john on 10/16/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface BaseMapViewController : UIViewController<MAMapViewDelegate, AMapSearchDelegate>

@property (nonatomic, strong) MAMapView * mapView;

@property (nonatomic, strong) AMapSearchAPI * search;

- (void)returnAction;

- (NSString *)getApplicationName;
- (NSString *)getApplicationScheme;
@end
