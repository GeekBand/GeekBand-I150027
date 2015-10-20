//
//  MRChangeNameViewController.m
//  MoRan
//
//  Created by john on 10/9/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRChangeNameViewController.h"
#import "MRRequestMineChangeName.h"
#import "MRAccountInfoTool.h"
#import "MRAccountInfo.h"
#import "MRMineTableViewController.h"

@interface MRChangeNameViewController ()

@end

@implementation MRChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    CGRect nameFrame = self.nameTextField.bounds;
//    nameFrame.origin.x = self.frame.origin.x;
//    nameFrame.origin.y = self.frame.origin.y;
//    nameFrame.size.width = self.frame.size.width;
//    nameFrame.size.height = self.frame.size.height;
//    self.nameTextField.frame = nameFrame;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonClicked:(id)sender {
    
    NSString * name = self.nameTextField.text;
    
    [MRRequestMineChangeName changeNameWithNewName:name Success:^(id anything) {
        
        MRAccountInfo * account = [MRAccountInfoTool getAccountInfo];
        
        account.userName = self.nameTextField.text;
        
        [MRAccountInfoTool saveAccountInfo:account];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } Failure:^(NSError * error) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"更改昵称失败"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"知道了"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}


@end
