//
//  MRResponseSquareLocationListComment.h
//  MoRan
//
//  Created by john on 10/18/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRResponseSquareLocationListComment : NSObject

@property (nonatomic, strong) NSString * msg;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) NSString * count;

@property (nonatomic, strong) NSArray * data;



@end
