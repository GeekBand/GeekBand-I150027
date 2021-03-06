//
//  MRLoginViewController.m
//  MoRan
//
//  Created by john on 15/9/14.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRLoginViewController.h"
#import "MRRequestLogin.h"
#import "NSString+Check.h"
#import "MRNetworkinigTool.h"
#import "MRAccountInfoTool.h"
#import "MRHistoryAccountInfo.h"

#define kOFFSET_FOR_KEYBOARD 30.0

@interface MRLoginViewController ()

@end

@implementation MRLoginViewController


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.loginButton.layer setCornerRadius:3];
    
    [self.waitView setContentMode:UIViewContentModeCenter];
    [self.waitView setFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.waitView];
    self.waitView.hidden = YES;

    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self initWithHistoryLogin];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self cleanTextField];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    // register for keyboard notifications
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    // unregister for keyboard notifications while not visible.
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardWillShowNotification
//                                                  object:nil];
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardWillHideNotification
//                                                  object:nil];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Custom Class Methods

- (void)cleanTextField {
    
    self.emailTextField.text = nil;
    
    self.passwordTextField.text = nil;
}

- (void)initWithHistoryLogin {
    
    MRHistoryAccountInfo * accountinfo = [MRAccountInfoTool getHistoryAccountInfo];
    
    if (accountinfo != nil) {
        
        self.emailTextField.text = accountinfo.email;
    }
}

#pragma mark - Custom Event Methods

- (IBAction)loginButtonClicked:(id)sender {
#warning Potentially incomplete method implementation.
    
    __block BOOL isError = false;
    __block NSString * errorMessage;
    
    NSString * email = self.emailTextField.text;
    NSString * password = self.passwordTextField.text;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        
        self.waitView.hidden = NO;
//        [self.view setNeedsDisplay];
        
    });
    dispatch_group_async(group, globalQueue, ^{
        
        if ([email isValidAsEmail] && [password isValidAsPassword]) {
            
            isError =true;
            errorMessage = @"邮箱或者密码错误";
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //登录成功的处理都在login函数中
                [MRRequestLogin loginWithEmail:email Password:password Success:^{
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                }Failure:^(NSError * error) {
                    
                    if (error) {
                        
                        [MRNetworkinigTool handleError:error Handler:^(NSDictionary *whatever) {
                            
                            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"邮箱或者密码错误" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                            
                            [alert show];
                        }];
                    }
                }];
            });
            
        }
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        self.waitView.hidden = YES;
        
        if (isError) {
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            
            [alert show];
        }
        
    });

    
    
    
}

- (IBAction)cancelButtonClicked:(id)sender {
#warning Potentially incomplete method implementation.
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

//-(void)keyboardWillShow {
//    // Animate the current view out of the way
//    if (self.view.frame.origin.y >= 0)
//    {
//        [self setViewMovedUp:YES];
//    }
//    else if (self.view.frame.origin.y < 0)
//    {
//        [self setViewMovedUp:NO];
//    }
//}
//
//-(void)keyboardWillHide {
//    if (self.view.frame.origin.y >= 0)
//    {
//        [self setViewMovedUp:YES];
//    }
//    else if (self.view.frame.origin.y < 0)
//    {
//        [self setViewMovedUp:NO];
//    }
//}


//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp) {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    } else {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.emailTextField resignFirstResponder];
    
    [self.passwordTextField resignFirstResponder];
}


#pragma mark - TextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.emailTextField) {
        
        [textField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
        
    } else if (textField == self.passwordTextField) {
        
        [textField resignFirstResponder];
    }
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (self.view.frame.origin.y >= 64) {
        
        [self setViewMovedUp:YES];
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.view.frame.origin.y < 64) {
        
        [self setViewMovedUp:NO];
    }
    
}

@end
