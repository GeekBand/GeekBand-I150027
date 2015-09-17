//
//  MRMainMessageImageScrollView.m
//  MoRan
//
//  Created by john on 15/8/31.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRMainMessageImageScrollView.h"


@implementation MRMainMessageImageScrollView

@synthesize _delegate = __delegate;

#pragma mark - Custom Class Method

- (void)setWithImageWithTextArray:(NSArray *)array IndexPath:(NSIndexPath *)indexPath {
    

    if(array == nil)return;
    
    self.contentSize = CGSizeMake((MRMessagePublishImageWidth + MRMessagePublishImageInterval) * [array count] - MRMessagePublishImageInterval, MRMessageScrollViewHeight);
    self.pagingEnabled = NO;
    self.maximumZoomScale = 1;
    self.minimumZoomScale = 1;
    
    
    //增加ContentView
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (MRMessagePublishImageWidth + MRMessagePublishImageInterval) * [array count] - MRMessagePublishImageInterval, MRMessageScrollViewHeight)];
    contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];
    
    if ([array count] == 0) {
        
        //
        
    } else {
        //添加图片和文字
        for (int i = 0; i < [array count]; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * (MRMessagePublishImageWidth + MRMessagePublishImageInterval), 0, MRMessagePublishImageWidth, MRMessageScrollViewHeight)];
            
            //添加图片
            MRMainMessageImageButton * imageView = [[MRMainMessageImageButton alloc] initWithArray:array IndexPath:indexPath ArrayNum:i];
            imageView.frame = CGRectMake(0, 0, MRMessagePublishImageWidth, MRMessagePublishImageHeight);
            imageView.backgroundColor = [UIColor clearColor];
            imageView._delegate = self._delegate;
            [self.imageArray addObject:imageView];
            [view addSubview:imageView];
            
            //添加文字
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, MRMessagePublishImageHeight + MRMessageImageToTextInterval, MRMessagePublishTextWidth, MRMessagePublishTextHeight)];
            label.font = [UIFont fontWithName:MRMessagePublishTextFont size:MRMessagePublishTextFontSize];
            label.numberOfLines = 0;
            //label.textAlignment = NSTextAlignmentNatural;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.backgroundColor = [UIColor clearColor];
//            label.textColor = [UIColor colorwithHex:0x444444];
            label.text = [(MRImageWithText *)array[i] text];
            [self.textArray addObject:label];
            [view addSubview:label];
            
            
            //判断文字是否超过两行,超过就增加省略号
            CGFloat height = [TextUtilities calculateHeightWithText:label.text TextWidth:MRMessagePublishTextWidth Font:label.font];
            if (height > MRMessagePublishTextHeight) {
                
                int clipLength;
                for (clipLength = 20; clipLength < label.text.length && MRMessagePublishTextHeight >= [TextUtilities calculateHeightWithText:[label.text substringToIndex:clipLength] TextWidth:MRMessagePublishTextWidth Font:label.font]; clipLength++);
                
                label.text = [NSString stringWithFormat:@"%@...", [label.text substringToIndex:clipLength - 2]];
            }
            
            //定制行间距
            NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:label.text];
            [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHex:0x444444] range:NSMakeRange(0, attrString.length)];
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            [style setLineSpacing:3];
            [attrString addAttribute:NSParagraphStyleAttributeName
                               value:style
                               range:NSMakeRange(0, attrString.length)];
            label.attributedText = attrString;

            [label sizeToFit];
            
            [contentView addSubview:view];
        }
    }
}



@end
