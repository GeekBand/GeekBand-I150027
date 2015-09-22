//
//  SignUpViewController.m
//  MoRan
//
//  Created by john on 15/9/14.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRSignUpViewController.h"
#import "UIColor+ColorWithHex.h"
#import "MRRequestModelSignUp.h"
#import "MRResponseSignUp.h"
#import "MRRequestSignUp.h"
#import <AFNetworking.h>
#import "MRResponseSignUpData.h"

#define SIGNUP_ERROR_FORMAT_OF_EMAIL @"邮箱格式不正确"
#define SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_NONUMBER @"密码必须包含数字"
#define SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_NOCHAR @"密码必须包含字母"
#define SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_LENGTH @"密码长度必须至少8位"
#define SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_ILLEGEL_CHAR @"密码不得包含初字母和数字以外其他的字符"
#define SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_INCONSISTENCY @"两次输入的密码不同"


@interface MRSignUpViewController ()

@end

@implementation MRSignUpViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置contentView
    CGSize size = [[UIScreen mainScreen] bounds].size;
    size.height -= self.navigationController.navigationBar.frame.size.height + 20;
    self.scrollView.contentSize = size;
    
    UIView * contentView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    contentView.backgroundColor = [UIColor whiteColor];
    
    [self.scrollView addSubview:contentView];
    
    
    //设置view的框架
    CGRect viewFrame = self.signUpView.frame;
    viewFrame.origin.x = viewFrame.origin.y = 0;
    viewFrame.size.width = self.scrollView.frame.size.width;
    viewFrame.size.height = contentView.frame.size.height;
    self.signUpView.frame = viewFrame;
    
    self.signUpView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [contentView addSubview:self.signUpView];
    
    //设置注册按钮圆角
    [self.submitButton.layer setCornerRadius:3];
    
    //设置点击屏幕键盘消失
    [self registerForKeyboardNotifications];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    //设置waitView
    CGRect waitViewFrame = self.waitView.frame;
    waitViewFrame.size.width =  [[UIScreen mainScreen] bounds].size.width;
    waitViewFrame.size.height = [[UIScreen mainScreen] bounds].size.height;
    self.waitView.frame = waitViewFrame;
    
    self.waitImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"littleYellow.gif"], nil];
    self.waitImageView.animationDuration = 1.0f;
    self.waitImageView.animationRepeatCount = 0;
    
}

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


- (IBAction)signUpButtonClicked:(id)sender {
    
    NSString * reminder;
    if ((reminder = [self checkTextField])) {
        
        //显示错误提示
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:reminder delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        [alert show];
        
    } else {
        
        
        
        [self.view addSubview:self.waitView];
        [self.view bringSubviewToFront:self.waitView];
        [self.waitImageView startAnimating];
        
        
        MRRequestModelSignUp * parameter = [[MRRequestModelSignUp alloc] initWithUserName:@"HelloWorld" PassWord:self.passwordTextField.text Email:self.emailTextField.text];
        [MRRequestSignUp postWithParameters:parameter Success:^(MRResponseSignUp * response) {
            
            //请求成功
            if (response.status == 1) {
                MRResponseSignUpData * data = response.data;
                
                
                NSLog(@"register success\n");
            }
            
//            [waitView removeFromSuperview];
            
            
        } Failure:^(NSError * error) {
            
            //请求失败
            NSLog(@"%@\n", error);
            
            [self handleError:error];
            
//            [waitView removeFromSuperview];
        }];
        
        
    }
}

- (void)dismissKeyboard {
    
    [self.activeField resignFirstResponder];
}

- (void)handleError:(NSError *)error {
#warning Potentially incomplete method implementation.
    
    NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
}

- (NSString *)checkTextField {
    
    
    //检查邮箱
    NSString * email = self.emailTextField.text;
    NSRange r = [email rangeOfString:@"@"];
    if (r.location == NSNotFound) {
        
        return SIGNUP_ERROR_FORMAT_OF_EMAIL;
    }
    
    
    //检查密码
    NSCharacterSet * cSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"];
    NSCharacterSet * nSet = [NSCharacterSet decimalDigitCharacterSet];
    
    NSString * password = self.passwordTextField.text;
    NSString * rePassword = self.reenterPasswordTextField.text;
    
    if ([password length] < 8) {
        return SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_LENGTH;
    }
    
    BOOL hasNumber = false;
    BOOL hasLetter = false;
    for (int i = 0; i < [password length]; i++) {
        
        unichar c = [password characterAtIndex:i];
        
        if ([cSet characterIsMember:c] == false) {
            return SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_ILLEGEL_CHAR;
        } else if ([nSet characterIsMember:c]) {
            hasNumber = true;
        } else {
            hasLetter = true;
        }
    }
    
    if (!hasNumber) {
        return SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_NONUMBER;
    }
    
    if (!hasLetter) {
        return SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_NOCHAR;
    }
    
    if ([password isEqualToString:rePassword] == false) {
        return SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_INCONSISTENCY;
    }
    
    return nil;
}


#pragma mark - TextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.emailTextField) {
        
        [textField resignFirstResponder];
        
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        
        [textField resignFirstResponder];
        
        [self.reenterPasswordTextField becomeFirstResponder];
        
    } else if (textField == self.reenterPasswordTextField) {
        
        [textField resignFirstResponder];
    }
    
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.activeField = nil;
}

#pragma mark - Keyboard Methods

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
    
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    
    if (self.scrollView.contentOffset.y > 0) {
        
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}




@end
