//
//  MRPictureDetailTableViewController.h
//  MoRan
//
//  Created by john on 15/9/9.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRImageWithText.h"

@interface MRPictureDetailTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIImageView *publishImage;
@property (strong, nonatomic) IBOutlet UILabel *publishText;
@property (strong, nonatomic) IBOutlet UILabel *publishLocation;
@property (strong, nonatomic) IBOutlet UIImageView *userPicture;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *publishTime;

@property (strong, nonatomic)MRImageWithText * message;
@property (nonatomic, copy) NSString * location;

@end
