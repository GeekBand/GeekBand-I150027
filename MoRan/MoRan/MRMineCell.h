//
//  MRMineCell.h
//  MoRan
//
//  Created by john on 15/9/3.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineViewSetting.h"

@interface MRMineCell : UITableViewCell



@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIImageView *_image;
@property (strong, nonatomic)UIImage * cellImage;
@property (copy, nonatomic)NSString * cellText;

@end
