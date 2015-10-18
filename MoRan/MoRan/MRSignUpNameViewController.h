//
//  MRSignUpNameViewController.h
//  MoRan
//
//  Created by john on 15/9/23.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRSignUpNameViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@property (nonatomic, copy)NSString * email;
@property (nonatomic, copy)NSString * password;

@end
