//
//  UIColor+HexString.h
//  NiceColors
//
//  Created by Mihaela Mihaljević Jakić on 29/10/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

// code from http://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string
// code from http://stackoverflow.com/questions/970475/how-to-compare-uicolors

#import <UIKit/UIKit.h>

typedef enum {
    HexColorType_RGB,
    HexColorType_ARGB,
    HexColorType_RRGGBB,
    HexColorType_AARRGGBB
} HexColorType;

@interface UIColor (HexString)
+ (NSString *)hexStringWithColor:(UIColor *)color type:(HexColorType)type;
+ (UIColor *)colorWithHexString:(NSString *) hexString;

+ (HexColorType)typeFromHexString:(NSString *)hexString;
- (BOOL)isEqualToColor:(UIColor *)otherColor;
@end
