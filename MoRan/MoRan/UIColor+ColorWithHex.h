//
//  UIColor+ColorWithHex.h
//  MoRan
//
//  Created by john on 15/9/1.
//  Copyright (c) 2015年 geekband-i150027. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIColor (ColorWithHex)

//用RGB十六进制产生颜色
+ (UIColor *)colorwithHex:(NSInteger)colorHex;

@end
