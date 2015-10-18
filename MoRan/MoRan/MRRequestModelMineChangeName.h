//
//  MRRequestModelMineChangeName.h
//  MoRan
//
//  Created by john on 10/9/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestModelBase.h"

@interface MRRequestModelMineChangeName : MRRequestModelBase

@property (nonatomic, copy, getter=theNewName) NSString * new_name;

- (instancetype)initWithName:(NSString *)name;

@end
