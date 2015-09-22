//
//  MRPublishTableViewController.m
//  MoRan
//
//  Created by john on 15/9/5.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRPublishTableViewController.h"
#import "PublishViewSetting.h"
#import "UIColor+ColorWithHex.h"
#import "CALayer+Border.h"

@interface MRPublishTableViewController ()

@end

@implementation MRPublishTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.publishText.delegate = self;
    
    self.view.backgroundColor = [UIColor colorwithHex:0xebecec];
    
    //设置文本框的编辑事件
    [self.publishText addTarget:self
                  action:@selector(textFieldDidChanged:)
        forControlEvents:UIControlEventEditingChanged];
    
    
    //设置取消键
    //    [self.cancelButton setTitle:@"\U0001F53D" forState:UIControlStateNormal];
    //    self.cancelButton.backgroundColor = [UIColor blackColor];
    self.cancelButton.imageView.tintColor = [UIColor whiteColor];
    [self.cancelButton setImage:[[UIImage imageNamed:@"backButton.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    
    //设置图片
    if (self.publishImage == nil || !self.imageIsFromCamera) {
        [self.publishImage setImage:[UIImage imageNamed:@"publishDefaultPicture"] forState:UIControlStateNormal];
    } else {
        
        [self.publishImage setImage:self.takenImage forState:UIControlStateNormal];
//        [self.publishImage setBackgroundImage:self.takenImage forState:UIControlStateNormal];
        
    }
    
    CGRect navigationBarFrame = self.navigationBarView.frame;
    navigationBarFrame.size.width = self.tableView.frame.size.width;
    navigationBarFrame.size.height = 64;
    self.navigationBarView.frame = navigationBarFrame;
    
    UIWindow *topWindow = [[[UIApplication sharedApplication].windows sortedArrayUsingComparator:^NSComparisonResult(UIWindow *win1, UIWindow *win2) {
        return win1.windowLevel - win2.windowLevel;
    }] lastObject];
    
    [topWindow addSubview:self.navigationBarView];
    
    
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        // For insetting with a navigation bar
        UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
        self.tableView.contentInset = insets;
        self.tableView.scrollIndicatorInsets = insets;
    }

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
//    self.tabBarController.tabBar.hidden = YES;
//
//    self.navigationItem.backBarButtonItem = nil;
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];
    

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationBarView removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Custom Class Method
- (IBAction)publishImageClicked:(id)sender {
#warning Potentially imcomplete method implementation.
    
}

- (IBAction)repictureButtonClicked:(id)sender {
#warning Potentially imcomplete method implementation. 
    
}

- (IBAction)cancelButtonClicked:(id)sender {
#warning Potentially imcomplete method implementation.
    
    self.takenImage = nil;
    self.publishText.text = nil;
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

- (void)blankButtonClicked:(UIButton *)button {

    [self.publishText resignFirstResponder];
    
    [self.blankButton removeFromSuperview];
    
}

- (void)textFieldDidChanged:(id)sender {
    
    self.publishTextNum.text = [NSString stringWithFormat:@"%i/60", self.publishText.text.length];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return section ? 1 : 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            height = MRPublishPictureImageHeight;
        } else {
            height = MRPublishPictureLabelHeight;
        }
    } else if (indexPath.section == 1) {
        height = MRPublishWordsHeight;
    } else {
        height = MRPublishLocationCellHeight;
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorwithHex:0xebecec];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return MRPublishCellFooterHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row > 0 || indexPath.section > 0) {
        
        //设置上下边线
        [cell.layer setTopBorderWidth:1.0f Color:[UIColor colorwithHex:0xd5d5d5].CGColor];
        
        if (indexPath.section != 2)
            [cell.layer setBottomBorderWidth:1.0f Color:[UIColor colorwithHex:0xd5d5d5].CGColor];
    }
}





//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
////    static NSString * reuseIdentifier = @"PublishCellReuseIdentifer";
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
//    
//    UITableViewCell * cell = [[UITableViewCell alloc] init];
//    
//    cell.contentView.frame = CGRectMake(0, 0, tableView.frame.size.width, 0);
//
////    if (cell == nil) {
////        cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
////        cell.contentView.frame = CGRectMake(0, 0, tableView.frame.size.width, 0);
////    }
//    
//    return cell;
//}


#pragma mark - UITextFieldDelegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //设置空白图片
    self.blankButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.blankButton addTarget:self action:@selector(blankButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.blankButton.backgroundColor = [UIColor clearColor];
    [self.tableView addSubview:self.blankButton];
    [self.tableView bringSubviewToFront:self.blankButton];
    
    [self.tableView bringSubviewToFront:self.publishText];
    
                              
}




@end
