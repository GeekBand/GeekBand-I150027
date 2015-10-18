//
//  InvertGeoViewController.m Referrence to officialDemo2D
//  MoRan
//
//  Created by john on 10/16/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "InvertGeoViewController.h"
#import "ReGeocodeAnnotation.h"
#import "MANaviAnnotationView.h"
#import "MRUserLocationButton.h"
#import "MRMessageArray.h"
#import "MRImageWithText.h"
#import "MRBaseLocation.h"

#define RightCallOutTag 1
#define LeftCallOutTag 2

@interface InvertGeoViewController ()

@property (nonatomic, assign) BOOL isDragging;
@property (nonatomic, assign) BOOL isSearchFromDragging;
@property (nonatomic, strong) ReGeocodeAnnotation *annotation;

@property (nonatomic, strong) MRUserLocationButton * userLocationButton;

@end

@implementation InvertGeoViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.userLocationButton = [[MRUserLocationButton alloc] init];
    
    [self.userLocationButton addTarget:self action:@selector(userLocationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    __weak InvertGeoViewController * weakSelf = self;
    
    for (int i = 0; i < [self.array count]; i++) {
        
        MRImageWithText * obj = [self.array objectAtIndex:i];
        [obj.location getAddressAndTitleWithHandler:^(NSString *address, NSString *title) {
            
            ReGeocodeAnnotation * annotation = [[ReGeocodeAnnotation alloc] initWithCoordinate:obj.location.coordinate Address:address Title:address];
            [weakSelf.mapView addAnnotation:annotation];
            
        }];
    }
    
//    [self initToolBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.navigationController.toolbar.barStyle      = UIBarStyleBlack;
//    self.navigationController.toolbar.translucent   = YES;
//    [self.navigationController setToolbarHidden:NO animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self.navigationController setToolbarHidden:YES animated:animated];
}

#pragma mark - Initialization

//- (void)initToolBar
//{
//    UIBarButtonItem *flexble = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                                                             target:nil
//                                                                             action:nil];
//    
//    UILabel *prompts = [[UILabel alloc] init];
//    prompts.text            = @"长按添加标注";
//    prompts.textAlignment   = NSTextAlignmentCenter;
//    prompts.backgroundColor = [UIColor clearColor];
//    prompts.textColor       = [UIColor whiteColor];
//    prompts.font            = [UIFont systemFontOfSize:20];
//    [prompts sizeToFit];
//    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:prompts];
//    self.toolbarItems     = [NSArray arrayWithObjects:flexble, item, flexble, nil];
//}

#pragma mark - Utilities

- (void)gotoDetailForReGeocode:(AMapReGeocode *)reGeocode
{
//    if (reGeocode != nil)
//    {
//        InvertGeoDetailViewController *invertGeoDetailViewController = [[InvertGeoDetailViewController alloc] init];
//        
//        invertGeoDetailViewController.reGeocode = reGeocode;
//        
//        [self.navigationController pushViewController:invertGeoDetailViewController animated:YES];
//    }
}

//- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
//{
//    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
//    
//    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//    regeo.requireExtension            = YES;
//    
//    [self.search AMapReGoecodeSearch:regeo];
//}

- (void)userLocationButtonClicked:(id)sender {
    
    self.mapView.userTrackingMode = (self.mapView.userTrackingMode + 1) % 2;
}

#pragma mark - MAMapViewDelegate

//- (void)mapView:(MAMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate
//{
//    _isSearchFromDragging = NO;
//    [self searchReGeocodeWithCoordinate:coordinate];
//}

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([view.annotation isKindOfClass:[ReGeocodeAnnotation class]])
    {
        if ([control tag] == RightCallOutTag)
        {
//            [self gotoDetailForReGeocode:[(ReGeocodeAnnotation*)view.annotation reGeocode]];
        }
        else if([control tag] == LeftCallOutTag)
        {
            MANaviConfig * config = [[MANaviConfig alloc] init];
            config.destination    = view.annotation.coordinate;
            config.appScheme      = [self getApplicationScheme];
            config.appName        = [self getApplicationName];
            config.strategy       = MADrivingStrategyShortest;
            
            if(![MAMapURLSearch openAMapNavigation:config])
            {
                [MAMapURLSearch getLatestAMapApp];
            }
        }
    }
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[ReGeocodeAnnotation class]])
    {
        static NSString *invertGeoIdentifier = @"invertGeoIdentifier";
        
        MANaviAnnotationView *poiAnnotationView = (MANaviAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:invertGeoIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MANaviAnnotationView alloc] initWithAnnotation:annotation
                                                                 reuseIdentifier:invertGeoIdentifier];
        }
        
        poiAnnotationView.animatesDrop   = YES;
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.draggable      = YES;
        
        //show detail by right callout accessory view.
        poiAnnotationView.rightCalloutAccessoryView     = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        poiAnnotationView.rightCalloutAccessoryView.tag = RightCallOutTag;
        
        //call online navi by left accessory.
        poiAnnotationView.leftCalloutAccessoryView.tag  = LeftCallOutTag;
        
        return poiAnnotationView;
    }
    
    return nil;
}

//- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState
//{
//    if (newState == MAAnnotationViewDragStateEnding)
//    {
//        _isSearchFromDragging = YES;
//        
//        CLLocationCoordinate2D coordinate = view.annotation.coordinate;
//        self.annotation = view.annotation;
//        
//        [self searchReGeocodeWithCoordinate:coordinate];
//    }
//}

- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    self.userLocationButton.mode = mode;
}

#pragma mark - AMapSearchDelegate

/* 逆地理编码回调. */
//- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
//{
//    if (response.regeocode != nil && _isSearchFromDragging == NO)
//    {
//        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(request.location.latitude, request.location.longitude);
//        ReGeocodeAnnotation *reGeocodeAnnotation = [[ReGeocodeAnnotation alloc] initWithCoordinate:coordinate
//                                                                                         reGeocode:response.regeocode];
//        
//        [self.mapView addAnnotation:reGeocodeAnnotation];
//        [self.mapView selectAnnotation:reGeocodeAnnotation animated:YES];
//    }
//    else /* from drag search, update address */
//    {
//        [self.annotation setAMapReGeocode:response.regeocode];
//        [self.mapView selectAnnotation:self.annotation animated:YES];
//    }
//}


@end
