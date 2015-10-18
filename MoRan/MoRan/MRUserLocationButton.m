//
//  MRUserLocationButton.m
//  MoRan
//
//  Created by john on 10/17/15.
//  Copyright © 2015 geekband-i150027. All rights reserved.
//

#import "MRUserLocationButton.h"

@implementation MRUserLocationButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    
    CGRect frame =  [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:CGRectMake(12, frame.size.height - 12 - 12, 12, 12)];
    
    if (self) {
        
        [self setImage:[UIImage imageNamed:@"userLocation"] forState:UIControlStateNormal];
        [self.imageView.layer setBottomBorderWidth:1.0f Color:[UIColor blueColor].CGColor];
        [self.imageView clipsToBounds];
        
        self.mode = MAUserTrackingModeNone;
        
        [self addObserver:self forKeyPath:@"userTrackingModeChanged" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"userTrackingModeChanged"])
    {
        NSNumber *showsNum = [change objectForKey:NSKeyValueChangeNewKey];
        
        if ([showsNum integerValue] == MAUserTrackingModeNone) {
            
            [self changeToUserTrackingModeNone];
        } else if ([showsNum integerValue] == MAUserTrackingModeFollow) {
            
            [self changeToUserTrackingModeFollow];
        }
    }
}

- (void)changeToUserTrackingModeNone {
    
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)changeToUserTrackingModeFollow {
    
    [self setBackgroundColor:[UIColor blueColor]];
}
@end
