//
//  MRPicture.m
//  MoRan
//
//  Created by john on 10/11/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRPicture.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>

@implementation MRPicture

- (instancetype)initWithURLofCompressedImage:(NSString *)compressedImageURL NormalImage:(NSString *)normalImageURL {
    
    self = [super init];
    
    if (self) {
        
        self.compressedImageURL = compressedImageURL;
        self.normalImageURL = normalImageURL;
    }
    
    return self;
}

- (void)setImageForSender:(id)sender Compressed:(BOOL)compressed {
    
    NSString * urlString;
    if (compressed && self.compressedImageURL) {
        
        urlString = self.compressedImageURL;
    } else {
        
        urlString = self.normalImageURL;
    }
    
    NSURL * url = [NSURL URLWithString:[urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    if ([[sender class] isSubclassOfClass:[UIImageView class]]) {
        
        [(UIImageView *)sender sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed];
    }
    
    if ([[sender class] isSubclassOfClass:[UIButton class]]) {
        
        [(UIButton *)sender sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRetryFailed];
    }
}

- (void)setImageForSender:(id)sender Compressed:(BOOL)compressed Completed:(void (^)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL))completed {
    
    NSString * urlString;
    if (compressed && self.compressedImageURL) {
        
        urlString = self.compressedImageURL;
    } else {
        
        urlString = self.normalImageURL;
    }

    NSURL * url = [NSURL URLWithString:[urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    if ([[sender class] isSubclassOfClass:[UIImageView class]]) {
        
        [(UIImageView *)sender sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed completed:completed];
    }
    
    if ([[sender class] isSubclassOfClass:[UIButton class]]) {
        
        [(UIButton *)sender sd_setBackgroundImageWithURL:url forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRetryFailed completed:completed];
    }
}



@end
