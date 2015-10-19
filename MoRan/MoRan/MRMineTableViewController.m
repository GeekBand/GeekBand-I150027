//
//  MRMineTableViewController.m
//  MoRan
//
//  Created by john on 15/9/3.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRMineTableViewController.h"
#import "NetworkRequestSetting.h"
#import "MRRequestMineSetImage.h"
#import "MRNetworkinigTool.h"
#import "MRAccountInfoTool.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "MRPublishTableViewController.h"
#import "AppDelegate.h"
#import "MRAccountInfoTool.h"
#import "MRAccountInfo.h"
#import "MRRequestMineGetImage.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface MRMineTableViewController ()

@property (nonatomic, strong) UIImagePickerController * imagePicker;

@property(nonatomic, strong)UIImage * takenImage;
@property(nonatomic, assign)BOOL imageIsFromCamera;

@end

@implementation MRMineTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    
    [self.userImage.layer setCornerRadius:MRMineHeaderImageRadius];
    [self.userImage setClipsToBounds:true];
    
    self.userName.numberOfLines = 1;
    
    self.userId.numberOfLines = 1;
    
    self.view.backgroundColor = [UIColor colorwithHex:0xebecec];
    
    self.imageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"nickname"], [UIImage imageNamed:@"headimage"], [UIImage imageNamed:@"signout"], [UIImage imageNamed:@"rate"], [UIImage imageNamed:@"follow"], [UIImage imageNamed:@"homepage"], nil];
    
    self.textArray = [[NSArray alloc] initWithObjects:@"更改昵称", @"设置头像", @"注销登录", @"评价我们", @"关注我们", @"官方网站", nil];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    ((MRTabBar *)self.tabBarController.tabBar)._delegate = self;
}

#pragma mark - Initialize Methods

- (void)initComponents {
    
    MRAccountInfo * account = [MRAccountInfoTool getAccountInfo];
    
    if (account.userName) {
        self.userName.text = account.userName;
    }
    if (account.userImage) {
        
        NSString * url = [MRRequestPrefix stringByAppendingString:[NSString stringWithFormat:@"user/show?user_id=%@", account.userId]];
        
        [self.userImage sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (error) {
                
                [MRNetworkinigTool showReminderWithString:@"头像图片加载失败"];
            }
        }];
    }
    if (account.email) {
        
        self.userId.text = account.email;
    }
}


#pragma mark - TableViewDelegate and TableViewDataSource Method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MRMineCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, MRMineCellFooterHeight)];
    view.backgroundColor = [UIColor colorwithHex:0xebecec];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return MRMineCellFooterHeight;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"MineViewCellIdentifier";
    
    MRMineCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[MRMineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.cellImage = self.imageArray[indexPath.section * 3 + indexPath.row];
    cell.cellText = self.textArray[indexPath.section * 3 + indexPath.row];
    if (indexPath.row != 2) {
        [cell.label.layer setBottomBorderWidth:1 Color:[UIColor colorwithHex:0xd5d5d5].CGColor];
    }
    
    ((MRMineCell *)cell)._image.image = cell.cellImage;
    [((MRMineCell *)cell)._image setContentMode:UIViewContentModeCenter];
    ((MRMineCell *)cell).label.text = cell.cellText;

    
    if (indexPath.row == 0) {
        [cell.layer setTopBorderWidth:1 Color:[UIColor colorwithHex:0xd5d5d5].CGColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#warning Potentially incomplete methods implementation.
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        
        if (isLogin) {
            
            if (indexPath.row == 0) {//Change my name
                
                [self performSegueWithIdentifier:@"ChangeName" sender:self];
                
            } else if (indexPath.row == 1) {//Set my Image
                
                
                UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                          delegate:self
                                                                 cancelButtonTitle:@"取消"
                                                            destructiveButtonTitle:nil
                                                                 otherButtonTitles:@"拍照", @"从手机相册选择", nil];
                [actionSheet showInView:self.view];
            } else {
                
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:@"您确定要退出？" preferredStyle:UIAlertControllerStyleAlert] ;
                
                UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:cancelAction];
                
                UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self.userImage setImage:nil forState:UIControlStateNormal];
                    self.userName.text = @"您还没有登录";
                    self.userId.text = nil;
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [appDelegate logout];
                    
                }];
                [alertController addAction:confirmAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            
        } else {
            
        }
        
    } else {
        
    }
}


//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UIImage *image;
//    NSString *text;
//    
//    if (indexPath.section == 0) {
//        switch (indexPath.row) {
//            case 0:
//                image = [UIImage imageNamed:@"nickname"];
//                text = @"更改昵称";
//                break;
//            case 1:
//                image = [UIImage imageNamed:@"headimage"];
//                text = @"设置头像";
//                break;
//                
//            default:
//                image = [UIImage imageNamed:@"signout"];
//                text = @"注销登录";
//                break;
//        }
//    } else {
//        switch (indexPath.row) {
//            case 0:
//                image = [UIImage imageNamed:@"rate"];
//                text = @"评价我们";
//                break;
//            case 1:
//                image = [UIImage imageNamed:@"follow"];
//                text = @"关注我们";
//                break;
//                
//            default:
//                image = [UIImage imageNamed:@"homepage"];
//                text = @"官方网站";
//                break;
//        }
//    }
//    
//    ((MRMineCell *)cell).image = image;
//    [((MRMineCell *)cell)._image setContentMode:UIViewContentModeCenter];
//    ((MRMineCell *)cell).label.text = text;
//
//}

#pragma mark - TabBarDelegate Method

- (void)publishButtonClicked:(UIButton *)publishButton{
    
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

#pragma mark - ActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = self.imagePicker;
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
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
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
}

#pragma mark - ImagePicker Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    if (picker == self.imagePicker) {
        
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [MRRequestMineSetImage setImageWithImage:image Success:^(id anything) {
            
            [self.userImage setImage:image forState:UIControlStateNormal];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } Failure:^(NSError * error) {
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                [MRNetworkinigTool showReminderWithString:@"上传图片失败"];
            }];
            
        }];
    } else {
        
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
    
}

#pragma mark - Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"Publish"]) {
        MRPublishTableViewController * vc = segue.destinationViewController;
        
        vc.takenImage = self.takenImage;
        vc.imageIsFromCamera = self.imageIsFromCamera;
    }
}


@end
