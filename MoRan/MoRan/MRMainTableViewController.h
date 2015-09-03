//
//  MRMainTableViewController.h
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRMainMessageCell.h"
#import "MRMainMessageImageButton.h"
#import "MRMainMessageImageScrollView.h"
#import "MRMessageArray.h"

@interface MRMainTableViewController : UITableViewController < UITableViewDelegate,
UITableViewDataSource, MRMainMessageImageScrollViewDelegate >

@property(nonatomic, strong)MRMessageArray * messageArray;

- (void)createMessageData;

@end
