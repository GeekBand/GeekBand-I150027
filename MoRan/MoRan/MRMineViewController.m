//
//  MRMineViewController.m
//  MoRan
//
//  Created by john on 15/8/23.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRMineViewController.h"

@interface MRMineViewController ()

@end

@implementation MRMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"my_selected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
