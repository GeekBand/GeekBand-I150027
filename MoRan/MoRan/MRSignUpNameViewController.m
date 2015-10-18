//
//  MRSignUpNameViewController.m
//  MoRan
//
//  Created by john on 15/9/23.
//  Copyright © 2015年 geekband-i150027. All rights reserved.
//

#import "MRSignUpNameViewController.h"
#import "ImageUtilities.h"

@interface MRSignUpNameViewController ()

@end

@implementation MRSignUpNameViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置图片动画
    CGRect imageFrame = self.imageView.frame;
    imageFrame.size.height = [ImageUtilities heightForImage:[UIImage imageNamed:@"littleYellowHappy1.jpg"] WhenItsWidth:imageFrame.size.width];
    self.imageView.frame = imageFrame;
    
    NSMutableArray * imageArray = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 10; i++) {
        
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"littleYellowHappy%i", i]]];
    }
    self.imageView.animationImages = imageArray;
    self.imageView.animationDuration = 1.0f;
    self.imageView.animationRepeatCount = 0;
    [self.imageView startAnimating];
    
    
    
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

- (IBAction)doneButtonCliked:(id)sender {
#warning Potentially incomplete method implementation.
}

- (IBAction)cancelButtonClicked:(id)sender {
#warning Potentially incomplete method implementation.
}

- (void)cleanTextField {
    
    self.nameTextField = nil;
}

@end
