//
//  MRRequestModelMineChangeName.m
//  MoRan
//
//  Created by john on 10/9/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestModelMineChangeName.h"

@implementation MRRequestModelMineChangeName

- (NSString *)theNewName {
    
    return _new_name;
}

- (instancetype)initWithName:(NSString *)name {
    
    self = [super init];
    
    if (self) {
        
        self.new_name = name;
    }

    return self;
}

@end
