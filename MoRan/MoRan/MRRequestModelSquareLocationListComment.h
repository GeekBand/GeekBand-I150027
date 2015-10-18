//
//  MRRequestModelSquareLocationListComment.h
//  MoRan
//
//  Created by john on 10/18/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestModelBase.h"

@interface MRRequestModelSquareLocationListComment : MRRequestModelBase

@property (nonatomic, strong) NSString * pic_id;

- (instancetype)initWithPictureId:(NSString *)picId;


@end
