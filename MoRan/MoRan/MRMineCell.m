//
//  MRMineCell.m
//  MoRan
//
//  Created by john on 15/9/3.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import "MRMineCell.h"

@implementation MRMineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        
        self._image = [[UIImageView alloc] initWithFrame:CGRectMake(MRMineCellImageleftMargin, 0, MRMineCellImageWidth, MRMineCellHeight)];
        [self.contentView addSubview:self._image];
        
        self.label =[[UILabel alloc] initWithFrame:CGRectMake(MRMineCellTestLeftMargin, 0, self.frame.size.width - MRMineCellTestLeftMargin, MRMineCellHeight)];
        self.label.font = [UIFont fontWithName:MRMinceCellTextFont size:MRMinceCellTextFontSize];
        
        [self.contentView addSubview:self.label];
    }
    
    return self;
}




@end
