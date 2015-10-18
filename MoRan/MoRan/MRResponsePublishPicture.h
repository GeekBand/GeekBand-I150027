//
//  MRResponsePublishPicture.h
//  MoRan
//
//  Created by john on 10/18/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRResponsePublishPictureData.h"

@interface MRResponsePublishPicture : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) MRResponsePublishPictureData * data;

@end
