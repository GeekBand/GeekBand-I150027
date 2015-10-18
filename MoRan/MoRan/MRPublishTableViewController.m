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
#import <MobileCoreServices/MobileCoreServices.h>
#import "MRNetworkinigTool.h"

@interface MRPublishTableViewController ()

@end

@implementation MRPublishTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.publishText.delegate = self;
    self.publishTextView.delegate = self;
    
    self.view.backgroundColor = [UIColor colorwithHex:0xebecec];
    
    
    
    
    
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
    //设置navigationBar
    CGRect navigationBarFrame = self.navigationBarView.frame;
    navigationBarFrame.size.width = self.tableView.frame.size.width;
    navigationBarFrame.size.height = 64;
    self.navigationBarView.frame = navigationBarFrame;
    
    UIWindow *topWindow = [[[UIApplication sharedApplication].windows sortedArrayUsingComparator:^NSComparisonResult(UIWindow *win1, UIWindow *win2) {
        return win1.windowLevel - win2.windowLevel;
    }] lastObject];
    
    [topWindow addSubview:self.navigationBarView];
    
    //设置取消键
    //    [self.cancelButton setTitle:@"\U0001F53D" forState:UIControlStateNormal];
    //    self.cancelButton.backgroundColor = [UIColor blackColor];
    self.cancelButton.imageView.tintColor = [UIColor whiteColor];
    [self.cancelButton setImage:[[UIImage imageNamed:@"backButton.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    //设置图片
    if (self.publishImage == nil) {
        
        [self.publishImage setTitle:@"您还没有选择图片" forState:UIControlStateNormal];
        
    } else {
        
        [self.publishImage setBackgroundImage:self.takenImage forState:UIControlStateNormal];
        //        [self.publishImage setBackgroundImage:self.takenImage forState:UIControlStateNormal];
        
    }
    
    [self textViewDidChange:self.publishTextView];

}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.navigationBarView removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Custom Class Method

- (void)cleanComponents {
    
    [self.publishImage setBackgroundImage:nil forState:UIControlStateNormal];
    
    [self.publishTextView setText:nil];
    
    [self.locationText setText:nil];
}
- (IBAction)publishButtonClicked:(id)sender {
    
    if ([self.publishTextView.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding] > 60) {
        
        [MRNetworkinigTool showReminderWithString:@"评论至多60个字"];
        
        return;
    }
    
    [self cleanComponents];
}

- (IBAction)publishImageClicked:(id)sender {
#warning Potentially imcomplete method implementation.
    
    if (self.takenImage == nil) {
        
        [self repictureButtonClicked:sender];
    }
}

- (IBAction)repictureButtonClicked:(id)sender {
#warning Potentially imcomplete method implementation. 
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)cancelButtonClicked:(id)sender {
#warning Potentially imcomplete method implementation.
    
    self.takenImage = nil;
    self.publishText.text = nil;
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    [self cleanComponents];
    
}

- (void)blankButtonClicked:(UIButton *)button {

    [self.publishTextView resignFirstResponder];
    
    [self.blankButton removeFromSuperview];
    
}


//- (void)textFieldDidChanged:(id)sender {
//
//    self.publishTextNum.text = [NSString stringWithFormat:@"%lu/60", self.publishText.text.length];
//}

#pragma mark - ActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            
            self.imageIsFromCamera = true;
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else {
            
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:@"无法获取相机" preferredStyle:UIAlertControllerStyleAlert] ;
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } else if (buttonIndex == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            
            self.imageIsFromCamera = false;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
}

#pragma mark - ImagePickerControllerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    

    NSString * type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if([type isEqualToString:(NSString *)kUTTypeImage]) {
        
        if (self.imageIsFromCamera) {
            
            UIImage * edited = [info objectForKey:UIImagePickerControllerEditedImage];
            
            self.takenImage = edited;
            
            [self.publishImage setBackgroundImage:edited forState:UIControlStateNormal];
            
            [self.publishImage setTitle:nil forState:UIControlStateNormal];
            
            //保存图片
            if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)UIImageWriteToSavedPhotosAlbum(edited, self, nil, nil);
        }
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
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

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    //设置空白图片
    self.blankButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.blankButton addTarget:self action:@selector(blankButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.blankButton.backgroundColor = [UIColor clearColor];
    [self.tableView addSubview:self.blankButton];
    [self.tableView bringSubviewToFront:self.blankButton];
    
    [self.tableView bringSubviewToFront:self.publishText];
    [self.tableView bringSubviewToFront:self.publishTextView];
}


- (void)textViewDidChange:(UITextView *)textView {
    
    if ([textView hasText]) {
        
        [self.publishText setPlaceholder:nil];
    } else {
        
        [self.publishText setPlaceholder:@"你想说的话..."];
    }
    
    NSInteger l = [textView.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    if (l > 60) {
        
        [textView setTextColor:[UIColor redColor]];
    } else {
        
        [textView setTextColor:[UIColor colorWithRed:150.0 / 255 green:150.0 / 255 blue:152.0 / 255 alpha:1]];
    }
    
    self.publishTextNum.text = [NSString stringWithFormat:@"%lu/60", [textView.text lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return NO;
}





@end
