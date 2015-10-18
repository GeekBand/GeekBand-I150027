//
//  MRResponseSquareLocationListNode.h
//  MoRan
//
//  Created by john on 10/18/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRResponseSquareLocationListNode : NSObject

@property (nonatomic, strong) NSString * addr;

@property (nonatomic, assign) CGFloat distance_in_meters;

@property (nonatomic, strong) NSString * id;

@end
