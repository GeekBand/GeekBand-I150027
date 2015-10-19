//
//  MRRequestSquareLocationList.h
//  MoRan
//
//  Created by john on 10/13/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRBaseLocation.h"

typedef void(^Success)(NSMutableArray * array);

@interface MRRequestSquareLocationList : NSObject


- (void)locationListRequestWithLocation:(MRBaseLocation *)location Distance:(NSInteger)distance Success:(Success)success Failure:(void (^)(NSError *))failure;

@end
