//
//  MRMainMessageCell.m
//  MoRan
//
//  Created by john on 15/8/30.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRMainMessageCell.h"


@implementation MRMainMessageCell

#pragma mark - Class Custom Method

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        [self addLocationView];
        
        [self addScrollView];
        
        
//        self.headButton = [[BLCellButton alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
//        self.headButton.backgroundColor = [UIColor clearColor];
//        [self.headButton addTarget:self
//                            action:@selector(headButtonClicked:)
//                  forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:self.headButton];
//        
//        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, _cellWidth - 70, 22)];
//        _nameLabel.backgroundColor = [UIColor clearColor];
//        _nameLabel.textColor = [UIColor blueColor];
//        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
//        [self.contentView addSubview:_nameLabel];
//        
//        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _messageLabel.backgroundColor = [UIColor clearColor];
//        _messageLabel.textColor = [UIColor blackColor];
//        _messageLabel.font = [UIFont systemFontOfSize:14];
//        _messageLabel.numberOfLines = 0;
//        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        [self.contentView addSubview:_messageLabel];
//        
//        _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _dateLabel.backgroundColor = [UIColor clearColor];
//        _dateLabel.textColor = [UIColor grayColor];
//        _dateLabel.font = [UIFont systemFontOfSize:13];
//        _dateLabel.textAlignment = NSTextAlignmentRight;
//        [self.contentView addSubview:_dateLabel];
    }
    
    return self;
}



- (void)addLocationView {
    self.locationView = [[UIView alloc] initWithFrame:CGRectMake(MRMessageLocationViewLeftMargin, 0, self.frame.size.width - MRMessageLocationViewLeftMargin - MRMessageLocationViewRightMargin, MRMessageLocationViewHeight)];
    
    //添加图片
    [self.locationView addSubview:[self addLocationImage]];
    
    //添加标签
    self.location = [self addLocationLabel];
    [self.locationView addSubview:self.location];
    
    [self.contentView addSubview:self.locationView];
    
    //增加边线
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0, MRMessageLocationViewHeight, self.locationView.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor colorwithHex:0xd5d5d5].CGColor;
    [self.locationView.layer addSublayer:bottomBorder];

}



- (UIImageView *)addLocationImage {
    
    //设置位置大小
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MRMessageLocationImageWidth, MRMessageLocationViewHeight)];
    
    //设置图片及居中
    imageView.image = [UIImage imageNamed:@"location"];
    [imageView setContentMode:UIViewContentModeCenter];
    
    
    return imageView;
}

- (UILabel *)addLocationLabel {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(MRMessageLocationImageWidth + 2, 0, self.frame.size.width - MRMessageLocationViewLeftMargin * 2 - MRMessageLocationViewRightMargin - MRMessageLocationImageWidth, MRMessageLocationViewHeight)];
    
    label.textColor = [UIColor colorwithHex:0x9f9fa0];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldFontWithFont:[UIFont fontWithName:MRMessagePublishTextFont size:MRMessagePublishTextFontSize]];
    label.numberOfLines = 1;
//    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    return label;
}

- (void)addScrollView {
    
    self.imageScrollView = [[MRMainMessageImageScrollView alloc] initWithFrame:CGRectMake(MRMessageScrollViewLeftMargin, MRMessageLocationViewHeight + MRMessageImageToTopInterval, self.frame.size.width - MRMessageScrollViewLeftMargin, MRMessageScrollViewHeight)];
    self.imageScrollView.backgroundColor = [UIColor clearColor];
    [self.imageScrollView setShowsHorizontalScrollIndicator:NO];
    [self.imageScrollView setShowsVerticalScrollIndicator:NO];
    
    [self.contentView addSubview:self.imageScrollView];
}


- (void)cleanComponents {

#warning Potentially incomplete method implementation.
//    self.location = nil;
//    self.imageScrollView = nil;
//    self.locationView = nil;
    
    
}

- (void)setLocationText:(NSString *)locationText {
    self.location.text = locationText;
}

- (void)setImageScrollViewImageWithText:(NSArray *)imageWithTextArray IndexPath:(NSIndexPath *)indexPath {
    //设置代理
    self.imageScrollView._delegate = self._delegate;
    
    [self.imageScrollView setWithImageWithTextArray:imageWithTextArray IndexPath:indexPath];

}

#pragma mark - MRMainMessageImageButtonDelegate Methods


@end
