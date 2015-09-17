//
//  MRPublishTableViewController.h
//  MoRan
//
//  Created by john on 15/9/5.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRPublishTableViewController : UITableViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate >

@property (strong, nonatomic) IBOutlet UIView *navigationBarView;

@property (strong, nonatomic) IBOutlet UIButton *publishImage;

@property (strong, nonatomic) IBOutlet UIButton *publishRepicture;
@property (strong, nonatomic) IBOutlet UITextField *publishText;
@property (strong, nonatomic) IBOutlet UILabel *publishTextNum;
@property (strong, nonatomic) IBOutlet UIImageView *locationImage;
@property (strong, nonatomic) IBOutlet UILabel *locationText;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong, nonatomic)UIImage * takenImage;
@property(nonatomic, assign)BOOL imageIsFromCamera;

@property(nonatomic, strong)UIButton * blankButton;

- (void)textFieldDidChanged:(id)sender;

@end
