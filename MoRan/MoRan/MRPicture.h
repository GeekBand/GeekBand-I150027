//
//  MRPicture.h
//  MoRan
//
//  Created by john on 10/11/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/SDImageCache.h>

@interface MRPicture : NSObject

@property (nonatomic, copy) NSString * compressedImageURL;

@property (nonatomic, copy) NSString * normalImageURL;

- (instancetype)initWithURLofCompressedImage:(NSString *)compressedImageURL NormalImage:(NSString *)normalImageURL;

- (void)setImageForSender:(id)sender Compressed:(BOOL)compressed;

- (void)setImageForSender:(id)sender Compressed:(BOOL)compressed Completed:(void (^)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL))completed;

@end
