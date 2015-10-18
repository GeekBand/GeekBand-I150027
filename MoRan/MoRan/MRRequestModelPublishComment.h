//
//  MRRequestModelPublishComment.h
//  MoRan
//
//  Created by john on 10/18/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRRequestModelBase.h"

@interface MRRequestModelPublishComment : MRRequestModelBase

@property (nonatomic, strong) NSString * pic_id;

@property (nonatomic, strong) NSString * comment;

-(instancetype)initWithPicId:(NSString *)picId Comment:(NSString *)comment;

@end
