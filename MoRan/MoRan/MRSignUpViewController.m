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
#import "MRSignUpNameViewController.h"
#import "NSString+Check.h"
#import "MRNetworkinigTool.h"


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
    
    NSMutableArray * imageArray = [[NSMutableArray alloc] init];
    for (int i = 1; i < 15; i++) {
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"littleYellow%i.jpg", i]]];
    }
    
    self.waitImageView.animationImages = imageArray;
    self.waitImageView.animationDuration = 2.0f;
    self.waitImageView.animationRepeatCount = 0;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self cleanTextField];
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
#warning Potentially incomplete method implementation.
    
    NSString * reminder;
    if (/*(reminder = [self checkTextField])*/false) {
        
        //显示错误提示
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:reminder delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        
        [alert show];
        
    } else {
        
        
        //加载等待页面
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.waitView];
//        [self.view bringSubviewToFront:self.waitView];
        [self.waitImageView startAnimating];
        
        //设置定时器
        dispatch_queue_t currentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, currentQueue, ^{
            
            [self waitTimeOver];
        });

        
        MRRequestModelSignUp * parameter = [[MRRequestModelSignUp alloc] initWithUserName:@"HelloWorld" PassWord:self.passwordTextField.text Email:self.emailTextField.text];
        [MRRequestSignUp postWithParameters:parameter Success:^(MRResponseSignUp * response) {
            
            //请求成功
            if (response.status == 1) {
                MRResponseSignUpData * data = response.data;
                
                
                
                NSLog(@"register success\n");
                
                [self cleanTextField];
            }
            
            [self removeWaitView];
            
        
            
            
        } Failure:^(NSError * error) {
            
            //请求失败
            [self removeWaitView];
            
            
            [MRNetworkinigTool handleError:error Handler:^(NSDictionary * serializedData) {
                
                if(serializedData == nil)return;
                
                if ((int)[serializedData objectForKey:@"status"] == 1 ) {
                    
                    //这个问题可能很严重，一般不可能发生，需要把刚才注册的号在服务端删掉
                }
                
                if ([serializedData[@"message"] isEqualToString:@"Email exists"]) {
                    
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:SIGNUP_ERROR_FORMAT_OF_EMAIL_EXISTS delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                    
                    [alert show];
                } else {
                    
                    //可能是未知错误，需要发给服务端处理
                }
            }];

            
        }];
        
        
    }
}


- (void)dismissKeyboard {
    
    [self.activeField resignFirstResponder];
}

//- (void)handleError:(NSError *)error {
//#warning Potentially incomplete method implementation.
//    
//    NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//    NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
//    
//    NSLog(@"%@",serializedData[@"message"]);
//    
//    if ((int)[serializedData objectForKey:@"status"] == 1 ) {
//        
//        //这个问题可能很严重，一般不可能发生，需要把刚才注册的号在服务端删掉
//    }
//    
//    if ([serializedData[@"message"] isEqualToString:@"Email exists"]) {
//        
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:SIGNUP_ERROR_FORMAT_OF_EMAIL_EXISTS delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
//        
//        [alert show];
//    } else {
//        
//        //可能是未知错误，需要发给服务端处理
//    }
//    
//}

- (NSString *)checkTextField {
    
    NSString * error = nil;
    NSString * password = self.passwordTextField.text;
    NSString * email = self.emailTextField.text;
    NSString * rePassword = self.reenterPasswordTextField.text;
    
    //检查邮箱
    error = [email isValidAsEmail];
    if (error) {
        
        return error;
    }
    
    
    //检查密码
    error = [password isValidAsPassword];
    if (error) {
        
        return error;
    }
    
    if ([password isEqualToString:rePassword] == false) {
        return SIGNUP_ERROR_FORMAT_OF_PASSWORD_AS_INCONSISTENCY;
    }
    
    return nil;
}

- (void)waitTimeOver {
    self.timeUp = true;
}

- (void)removeWaitView {
    
    while (!self.timeUp) {
        [NSThread sleepForTimeInterval:1.0f];
    }
    
    [self.waitView removeFromSuperview];
    
    self.timeUp = false;
}

- (void)cleanTextField {
    
    self.emailTextField.text = nil;
    
    self.passwordTextField.text = nil;
    
    self.reenterPasswordTextField.text = nil;
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

#pragma mark - Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"SignUpToName"]) {
        
        MRSignUpNameViewController * des = segue.destinationViewController;
        des.email = self.emailTextField.text;
        des.password = self.passwordTextField.text;
    }
}


@end
