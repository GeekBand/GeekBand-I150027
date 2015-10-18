//
//  MRMineTableViewController.h
//  MoRan
//
//  Created by john on 15/9/3.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineViewSetting.h"
#import "UIColor+ColorWithHex.h"
#import "MRMineCell.h"
#import "CALayer+Border.h"
#import "MRTabBar.h"

@interface MRMineTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, MRTabBarDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UIButton *userImage;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userId;

@property(nonatomic, strong)NSArray *imageArray;
@property(nonatomic, strong)NSArray *textArray;

@end
