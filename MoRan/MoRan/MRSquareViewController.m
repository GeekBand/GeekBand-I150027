//
//  MRSquareViewController.m
//  MoRan
//
//  Created by john on 15/8/23.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRSquareViewController.h"


@interface MRSquareViewController ()

@end

@implementation MRSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置TabBar
    self.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"square_selected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置NavigationBar
    [self.navigationBar.layer setBottomBorderWidth:1.0f Color:[UIColor colorwithHex:0xc76935].CGColor];
    
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

@end
