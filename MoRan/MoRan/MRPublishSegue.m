//
//  MRPublishSegue.m
//  MoRan
//
//  Created by john on 15/9/6.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRPublishSegue.h"
#import "MRMainTableViewController.h"
#import "MRPublishTableViewController.h"

@implementation MRPublishSegue

- (void)perform {
    
    
    MRMainTableViewController * source = (MRMainTableViewController *)self.sourceViewController;
    MRPublishTableViewController * destination = (MRPublishTableViewController *)self.destinationViewController;
    
    [source presentViewController:destination animated:YES completion:nil];
    
//    [UIView animateWithDuration:0.75 animations:^{
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:source.navigationController.view cache:NO];
//    }];
}


@end
