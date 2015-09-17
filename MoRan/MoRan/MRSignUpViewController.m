//
//  SignUpViewController.m
//  MoRan
//
//  Created by john on 15/9/14.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRSignUpViewController.h"
#import "UIColor+ColorWithHex.h"

@interface MRSignUpViewController ()

@end

@implementation MRSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置contentView
    self.scrollView.contentSize = [[UIScreen mainScreen] bounds].size;
    
    UIView * contentView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    contentView.backgroundColor = [UIColor whiteColor];
    
    [self.scrollView addSubview:contentView];
    
    [contentView addSubview:self.signUpView];
    
    //设置view的框架
    CGRect viewFrame = self.signUpView.frame;
    viewFrame.origin.x = viewFrame.origin.y = 0;
    viewFrame.size.width = self.scrollView.frame.size.width;
    viewFrame.size.height = self.scrollView.frame.size.height;
    self.signUpView.frame = viewFrame;
    
    self.signUpView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    [self registerForKeyboardNotifications];
    
    [self.submitButton.layer setCornerRadius:3];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
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
