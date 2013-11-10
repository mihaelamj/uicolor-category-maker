//
//  UIImage+Colored.m
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 06/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "UIImage+Colored.h"

@implementation UIImage (Colored)

+ (UIImage *)imageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height
{
    CGRect rect = CGRectMake(0, 0, width, height);
    
    //Create a width by height pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    //Fill image with color
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
