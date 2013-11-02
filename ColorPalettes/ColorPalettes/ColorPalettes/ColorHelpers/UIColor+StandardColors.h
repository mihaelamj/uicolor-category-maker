//
//  UIColor+StandardColors.h
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/19/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (StandardColors)

+ (NSArray *)standardColorNames;
+ (UIColor *)randomStandardColor;
+ (NSArray *)standardColorNamesExcludingColors:(NSArray *)excludingColors;
+ (UIColor *)colorFromName:(NSString *)colorName;
@end
