//
//  MRMineTableViewController.m
//  MoRan
//
//  Created by john on 15/9/3.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRMineTableViewController.h"

@implementation MRMineTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    
    [self.userImage.layer setCornerRadius:MRMineHeaderImageRadius];
    [self.userImage setClipsToBounds:true];
    
    self.userName.numberOfLines = 1;
    
    self.userId.numberOfLines = 1;
    
    self.view.backgroundColor = [UIColor colorwithHex:0xebecec];
    
    self.imageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"nickname"], [UIImage imageNamed:@"headimage"], [UIImage imageNamed:@"signout"], [UIImage imageNamed:@"rate"], [UIImage imageNamed:@"follow"], [UIImage imageNamed:@"homepage"], nil];
    
    self.textArray = [[NSArray alloc] initWithObjects:@"更改昵称", @"设置头像", @"注销登录", @"评价我们", @"关注我们", @"官方网站", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    ((MRTabBar *)self.tabBarController.tabBar)._delegate = self;
}

#pragma mark - TableViewDelegate and TableViewDataSource Method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MRMineCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, MRMineCellFooterHeight)];
    view.backgroundColor = [UIColor colorwithHex:0xebecec];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return MRMineCellFooterHeight;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"MineViewCellIdentifier";
    
    MRMineCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[MRMineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.cellImage = self.imageArray[indexPath.section * 3 + indexPath.row];
    cell.cellText = self.textArray[indexPath.section * 3 + indexPath.row];
    if (indexPath.row != 2) {
        [cell.label.layer setBottomBorderWidth:1 Color:[UIColor colorwithHex:0xd5d5d5].CGColor];
    }
    
    ((MRMineCell *)cell)._image.image = cell.cellImage;
    [((MRMineCell *)cell)._image setContentMode:UIViewContentModeCenter];
    ((MRMineCell *)cell).label.text = cell.cellText;

    
    if (indexPath.row == 0) {
        [cell.layer setTopBorderWidth:1 Color:[UIColor colorwithHex:0xd5d5d5].CGColor];
    }
    
    return cell;
}


//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UIImage *image;
//    NSString *text;
//    
//    if (indexPath.section == 0) {
//        switch (indexPath.row) {
//            case 0:
//                image = [UIImage imageNamed:@"nickname"];
//                text = @"更改昵称";
//                break;
//            case 1:
//                image = [UIImage imageNamed:@"headimage"];
//                text = @"设置头像";
//                break;
//                
//            default:
//                image = [UIImage imageNamed:@"signout"];
//                text = @"注销登录";
//                break;
//        }
//    } else {
//        switch (indexPath.row) {
//            case 0:
//                image = [UIImage imageNamed:@"rate"];
//                text = @"评价我们";
//                break;
//            case 1:
//                image = [UIImage imageNamed:@"follow"];
//                text = @"关注我们";
//                break;
//                
//            default:
//                image = [UIImage imageNamed:@"homepage"];
//                text = @"官方网站";
//                break;
//        }
//    }
//    
//    ((MRMineCell *)cell).image = image;
//    [((MRMineCell *)cell)._image setContentMode:UIViewContentModeCenter];
//    ((MRMineCell *)cell).label.text = text;
//
//}

#pragma mark - TabBarDelegate Method

- (void)publishButtonClicked:(UIButton *)publishButton{
    
    [self performSegueWithIdentifier:@"Publish" sender:publishButton];
}



@end
