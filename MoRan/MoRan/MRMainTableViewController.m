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

@implementation MRMainTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.messageArray = [[MRMessageArray alloc] init];
    
    self.tableView.backgroundColor = [UIColor colorwithHex:0xebecec];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    ((MRTabBar *)self.tabBarController.tabBar)._delegate = self;
}

#pragma mark - Custom Class Methods

- (void)createMessageData {
    
}

#pragma mark - Custom Event Methods




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
        UIImage * original = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        self.takenImage = original;
        //保存图片
        if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)UIImageWriteToSavedPhotosAlbum(original, self, nil, nil);
    }
    
    [self dismissViewControllerAnimated:NO completion:^(void){
        
        [self goToPublishView];
    }];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:NO completion:nil];
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
    }
}

@end