//
//  MRMainTableViewController.h
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRMessageArray.h"
#import "MRMainMessageImageButton.h"
#import "MRTabBar.h"
#import <MobileCoreServices/MobileCoreServices.h>



@interface MRMainTableViewController : UITableViewController < UITableViewDelegate, UITableViewDataSource, MRMainMessageImageButtonDelegate, MRTabBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate >


@property(nonatomic, strong)MRMessageArray * messageArray;
@property(nonatomic, strong)UIImage * takenImage;
@property(nonatomic, assign)BOOL imageIsFromCamera;
@property(nonatomic ,strong)MRImageWithText * info;



@end
