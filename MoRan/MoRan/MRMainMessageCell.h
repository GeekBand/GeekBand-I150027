//
//  MRMainMessageCell.h
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainviewSetting.h"
#import "UIColor+ColorWithHex.h"
#import "UIFont+Bold.h"
#import "MRMainMessageImageScrollView.h"
#import "CALayer+Border.h"
#import "MRMainMessageImageButton.h"






@interface MRMainMessageCell : UITableViewCell

@property(nonatomic, strong)UIView * locationView;
@property(nonatomic, strong)UILabel * location;
@property(nonatomic, strong)MRMainMessageImageScrollView * imageScrollView;
@property(nonatomic, strong)id<MRMainMessageImageButtonDelegate> _delegate;

- (void)setLocationText:(NSString *)locationText;
- (void)setImageScrollViewImageWithText:(NSArray *)imageWithTextArray IndexPath:(NSIndexPath *)indexPath;

- (void)cleanComponents;

- (void)addLocationView;
- (UIImageView *)addLocationImage;
- (UILabel *)addLocationLabel;
- (void)addScrollView;


@end

