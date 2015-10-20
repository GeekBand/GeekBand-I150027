//
//  MRMainTableViewController.m
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRMainTableViewController.h"
#import "MRMainMessageCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "MRPublishTableViewController.h"
#import "MRPictureDetailTableViewController.h"
#import "MRNetworkinigTool.h"
#import <MJRefresh.h>
#import "MoRan-Swift.h"
#import "MRDetailLocation.h"
#import "InvertGeoViewController.h"

@interface MRMainTableViewController ()

@property(nonatomic, strong)UIImage * takenImage;
@property(nonatomic, assign)BOOL imageIsFromCamera;

@property(nonatomic, strong) MRBaseLocation * userLocation;

@property (nonatomic, strong) AMapSearchAPI * search;

@end

@implementation MRMainTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.messageArray = [[MRMessageArray alloc] init];
    
    
    //定位管理
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        [self.locationManager requestWhenInUseAuthorization];
    } else {
        
        [self.locationManager startUpdatingLocation];
    }
    
    
    self.tableView.backgroundColor = [UIColor colorwithHex:0xebecec];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBarButton setTitle:@"杭州" forState:UIControlStateNormal];
    [self.leftBarButton addTarget:self action:@selector(chooseCityButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBarButton setFrame:CGRectMake(0, 0, 48, 24)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBarButton];
    
    [self initRefresh];
    
    [self initSearch];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    ((MRTabBar *)self.tabBarController.tabBar)._delegate = self;
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Custom Class Methods

- (void)createMessageData {
    
}

- (void)initRefresh {
    
    __weak typeof(self) weakSelf = self;
    __weak UITableView *tableView = self.tableView;
    
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [self.locationManager startUpdatingLocation];
        });
    }];
    tableView.header.automaticallyChangeAlpha = YES;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.userLocation.distance *= 2;
            //刷新请求
            [self.messageArray refreshWithLocation:self.userLocation Distance:self.userLocation.distance Complete:^(NSError *error) {
                
                if (error) {
                    
                    MRLog(@"LocationListRequest fails when the distance increases.");
                } else {
                    
                    //加载数据
                    [tableView reloadData];
                }
                
                [tableView.footer endRefreshing];
                
            }];
        });
    }];
    footer.hidden = YES;
    tableView.footer = footer;
}

- (void)initSearch {
    
    self.search = [AMapSearchAPI new];
    self.search.delegate = self;
}

- (void)searchLocation {
    
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = self.leftBarButton.titleLabel.text;
    
    [self.search AMapGeocodeSearch:geo];
}

- (void)request {
    
    __weak UITableView *tableView = self.tableView;
    
    [self.messageArray refreshWithLocation:self.userLocation Distance:self.userLocation.distance Complete:^(NSError *error) {
        
        if (error) {
            
            
            MRLog(@"LocationListRequest fails!");
            [MRNetworkinigTool handleError:error Handler:nil];
            
        } else {
            
            [tableView reloadData];
        }
        
        if ([tableView.header isRefreshing]) {
            
            [tableView.header endRefreshing];
        }
        
        if ([tableView.footer isRefreshing]) {
            
            [tableView.footer endRefreshing];
        }
        
    }];

}

#pragma mark - Custom Event Methods


- (void)chooseCityButtonClicked:(id)sender {
    

    CFCityPickerVC * cityPicker = [CFCityPickerVC new];
    [self.navigationController presentViewController:cityPicker animated:YES completion:nil];
}


#pragma mark - UITableViewDelegate and UITableViewDataSourceDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.messageArray count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0)];
    view.backgroundColor = [UIColor colorwithHex:0xebecec];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return MRMessageCellHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([_messageArray count] > indexPath.row) {
//        BLMessage *message = (BLMessage *)[_messageArray objectAtIndex:indexPath.row];
//        return [BLCustomCell calculateCellHeightWithMessage:message];
//    }
    return MRMessageCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MainViewCellIdentifier";
    MRMainMessageCell *cell = (MRMainMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MRMainMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell._delegate = self;
    }
    
    [cell cleanComponents];
    
    if ([self.messageArray count] > indexPath.section) {
        MRMainPublishMessage *message = [self.messageArray objectAtIndex:indexPath.section];
        
        NSInteger dis = 500;
        while (message.location.distance > dis) {
            dis *= 2;
        }
        self.navigationController.title = [NSString stringWithFormat:@"附近%li米内", (long)dis];
        
        [cell setLocationText:message.locationText];
        [cell setImageScrollViewImageWithText:message.imageArrayWithText IndexPath:indexPath];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //设置上下边线
    [cell.layer setTopBorderWidth:1.0f Color:[UIColor colorwithHex:0xd5d5d5].CGColor];
    [cell.layer setBottomBorderWidth:1.0f Color:[UIColor colorwithHex:0xd5d5d5].CGColor];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) {
//        return UITableViewCellEditingStyleInsert;
//    }
//    return UITableViewCellEditingStyleDelete;
//}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0 || indexPath.row == 1) {
//        return YES;
//    }
//    return NO;
//}

//- (NSString *)tableView:(UITableView *)tableView
//titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除此行";
//}

//-(void)tableView:(UITableView *)tableView
//commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
//forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleInsert) {
//        BLUser *user = [BLUser userWithName:@"12345" headImagePath:nil lifePhotoPath:nil];
//        BLMessage *message = [BLMessage messageWithSender:user text:@"1234567890-esrdfghjkl;" sendDate:[NSDate date]];
//        [_messageArray insertObject:message atIndex:indexPath.row];
//        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
//                         withRowAnimation:UITableViewRowAnimationLeft];
//    }else if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_messageArray removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
//    }
////            [tableView reloadData];
//}



#pragma mark - MRMainMessageImageButtonDelegate Methods

- (void)imageButtonClicked:(MRMainMessageImageButton *)button {
    
    MRMainPublishMessage *message = [_messageArray objectAtIndex:button.cellSection];
    self.info = message.imageArrayWithText[button.arrayNum];
    
    [self performSegueWithIdentifier:@"PictureDetail" sender:self];
}

#pragma mark - MRTabBarDelegate Method

- (void)publishButtonClicked:(UIButton *)publishButton {
    
#warning Potentially incomplete method implementation.
    
    //设置照相
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setDelegate:self];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        
        self.imageIsFromCamera = true;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        
        
        self.imageIsFromCamera = false;
        
        [self goToPublishView];
    }
    
   
}

- (void)publishButtonLongPress:(UIButton *)button {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setDelegate:self];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        imagePicker.allowsEditing = YES;
        
        self.imageIsFromCamera = false;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        
        
        self.imageIsFromCamera = false;
        
        [self goToPublishView];
    }
}

- (void)goToPublishView {

#warning Potentially incomplete method implementation.
    [self performSegueWithIdentifier:@"Publish" sender:self];
    

}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
#warning Potentially incomplete method implementation.
    
    //存储图片
    NSString * type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if([type isEqualToString:(NSString *)kUTTypeImage]) {
        
        if (self.imageIsFromCamera) {
            
            
            UIImage * original = [info objectForKey:UIImagePickerControllerOriginalImage];
            
            self.takenImage = original;
            //保存图片
            if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)UIImageWriteToSavedPhotosAlbum(original, self, nil, nil);
        } else {
            
            UIImage * edited = [info objectForKey:UIImagePickerControllerEditedImage];
            
            self.takenImage = edited;
        }
    }
    [self dismissViewControllerAnimated:NO completion:^(void){
        
        [self goToPublishView];
    }];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            MRLog(@"User still thinking..");
            
            [self searchLocation];
        } break;
        case kCLAuthorizationStatusDenied: {
            
            MRLog(@"User hates you");
            
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
                
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"定位服务未开启" message:@"请到系统设置中开启定位服务" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"暂不" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:cancel];
                
                UIAlertAction * setting = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                [alertController addAction:setting];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            } else {
                
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"定位服务未开启" message:@"请到设置->隐私->定位中开启" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:cancel];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [_locationManager startUpdatingLocation]; //Will update location immediately
        } break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
#warning Potentially incomplete method implementation.
    
    CLLocation *location = [locations lastObject];
    self.userLocation = [[MRBaseLocation alloc] initWithLongitude:location.coordinate.longitude Latitude:location.coordinate.latitude];
    self.userLocation.distance = 500;
    
    [self.locationManager stopUpdatingLocation];
    
    MRLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
    
    [self request];
    
}

#pragma mark - AMapSearchDelegate

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        return;
    }
    
    
    AMapGeocode * geocode = response.geocodes[0];
    
    self.userLocation = [[MRBaseLocation alloc] initWithLongitude:geocode.location.longitude Latitude:geocode.location.latitude];
    
    self.userLocation.distance = 500;
    
    [self request];
    
    MRLog(@"lat%f - lon%f", geocode.location.latitude, geocode.location.longitude);
}


#pragma mark - Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"Publish"]) {
        MRPublishTableViewController * vc = segue.destinationViewController;
        
        vc.takenImage = self.takenImage;
        vc.imageIsFromCamera = self.imageIsFromCamera;
    } else if ([[segue identifier] isEqualToString:@"PictureDetail"]) {
        MRPictureDetailTableViewController * vc = segue.destinationViewController;
        
        vc.message = self.info;
    } else if ([[segue identifier] isEqualToString:@"Map"]) {
        
        InvertGeoViewController * vc = segue.destinationViewController;
        
        vc.array = self.messageArray;
    }
}

@end
