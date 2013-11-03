//
//  UIColor+HexString.m
//  NiceColors
//
//  Created by Mihaela Mihaljević Jakić on 29/10/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

// code from http://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string
// code from http://stackoverflow.com/questions/970475/how-to-compare-uicolors

/*
 Hex color formats:
 
 #RGB           (Red: #F00).
 #ARGB          (Red with Alpha 5: #5F00).
 #RRGGBB        (Red : #FF0000).
 #AARRGGBB      (Red with Alpha 50: 50FF0000)
 */

#import "UIColor+HexString.h"

@implementation UIColor (HexString)

#pragma mark - Public methods

+ (HexColorType)typeFromHexString:(NSString *)hexString
{
    HexColorType type = HexColorType_RGB;
    //guess the hex string format based on length, heuristic :)
    switch ([hexString length]) {
        case 3: // #RGB
            break;
        case 4: // #ARGB
            type = HexColorType_ARGB;
            break;
        case 6: // #RRGGBB
            type = HexColorType_RRGGBB;
            break;
        case 8: // #AARRGGBB
            type = HexColorType_AARRGGBB;
            break;
        default:
            break;
    }
    return type;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    //remove #
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    //get the hex format type
    HexColorType type = [UIColor typeFromHexString:colorString];
    switch (type) {
        case HexColorType_RGB:
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case HexColorType_ARGB:
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case HexColorType_RRGGBB:
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case HexColorType_AARRGGBB:
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (NSDictionary *)colorComponentsForHexColor:(NSString *)hexString
{
    //remove #
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    
    //get the hex format type
    HexColorType type = [UIColor typeFromHexString:colorString];
    
    unsigned hexComponentRed, hexComponentGreen, hexComponentBlue, hexComponentAlpha;
    switch (type) {
        case HexColorType_RGB:
            hexComponentAlpha = 255.0f;
            hexComponentRed   = [self hexComponentFrom: colorString start: 0 length: 1];
            hexComponentGreen = [self hexComponentFrom: colorString start: 1 length: 1] ;
            hexComponentBlue  = [self hexComponentFrom: colorString start: 2 length: 1];
            break;
        case HexColorType_ARGB:
            hexComponentAlpha = [self hexComponentFrom: colorString start: 0 length: 1];
            hexComponentRed   = [self hexComponentFrom: colorString start: 1 length: 1];
            hexComponentGreen = [self hexComponentFrom: colorString start: 2 length: 1];
            hexComponentBlue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case HexColorType_RRGGBB:
            hexComponentAlpha = 255.0f;
            hexComponentRed   = [self hexComponentFrom: colorString start: 0 length: 2];
            hexComponentGreen = [self hexComponentFrom: colorString start: 2 length: 2];
            hexComponentBlue  = [self hexComponentFrom: colorString start: 4 length: 2];
            break;
        case HexColorType_AARRGGBB:
            hexComponentAlpha = [self hexComponentFrom: colorString start: 0 length: 2];
            hexComponentRed   = [self hexComponentFrom: colorString start: 2 length: 2];
            hexComponentGreen = [self hexComponentFrom: colorString start: 4 length: 2];
            hexComponentBlue  = [self hexComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return @{@"alpha" : [NSNumber numberWithInt:hexComponentAlpha],
             @"red" : [NSNumber numberWithInt:hexComponentRed],
             @"green" : [NSNumber numberWithInt:hexComponentGreen],
             @"blue" : [NSNumber numberWithInt:hexComponentBlue]};
}

+ (NSString *)hexStringWithColor:(UIColor *)color type:(HexColorType)type
{
    //convert color to RGB space if needed
    UIColor *colorRGB = [UIColor convertColorToRGBSpace:color];
    
    //components -> array of intensity values for the color components (including alpha)
    //CGColor -> The Quartz color reference that corresponds to the color
    const CGFloat *components = CGColorGetComponents(colorRGB.CGColor);
    
    int redInt = (int)(components[0] * 255);
    int greenInt = (int)(components[1] * 255);
    int blueInt = (int)(components[2] * 255);
    int alphaInt = (int)(components[3] * 255);
    
    NSString *hexString = nil;
    switch (type) {
        case HexColorType_RGB:
        case HexColorType_RRGGBB:
            hexString = [NSString stringWithFormat:@"%02X%02X%02X", redInt, greenInt, blueInt];
            break;
        case HexColorType_ARGB:
        case HexColorType_AARRGGBB:
            hexString = [NSString stringWithFormat:@"%02X%02X%02X%02X", alphaInt, redInt, greenInt, blueInt];
            break;
        default:
            break;
    }
    
    if (HexColorType_RGB == type || HexColorType_ARGB == type) {
        //delete every other character
        hexString = [UIColor halfHexString:hexString];
    }
    return hexString;
}

- (BOOL)isEqualToColor:(UIColor *)otherColor
{
    if (self == otherColor)
        return YES;
    
    UIColor *selfColorRGB = [UIColor convertColorToRGBSpace:self];
    UIColor *otherColorRGB = [UIColor convertColorToRGBSpace:otherColor];
    
    return [selfColorRGB isEqual:otherColorRGB];
}

#pragma mark - Private

+ (UIColor *)convertColorToRGBSpace:(UIColor *)color
{
    CGColorSpaceRef colorSpaceRGB = CGColorSpaceCreateDeviceRGB();
    UIColor *colorRGB = color;
    
    //if in monochrome space then convert to RBG
    if (CGColorSpaceGetModel(CGColorGetColorSpace(colorRGB.CGColor)) == kCGColorSpaceModelMonochrome) {
        const CGFloat *oldComponents = CGColorGetComponents(colorRGB.CGColor);
        
        CGFloat components[4] = {oldComponents[0], oldComponents[0], oldComponents[0], oldComponents[1]};
        CGColorRef colorRef = CGColorCreate(colorSpaceRGB, components);
        
        UIColor *colorRGB = [UIColor colorWithCGColor:colorRef];
        CGColorRelease(colorRef);
        return colorRGB;
    }
    else
        return colorRGB;
};

+ (NSString *)halfHexString:(NSString *)fullHexString
{
    NSMutableString *mutableFullHex = [NSMutableString stringWithCapacity:[fullHexString length]];
    [mutableFullHex setString:fullHexString];

    for (int index = 0; index < [fullHexString length] / 2; index++) {
        [mutableFullHex replaceCharactersInRange:NSMakeRange(index, 1)
                           withString:@""];
    }
    return [NSString stringWithString:mutableFullHex];
}

+ (NSString *)fullHexFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    return length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length
{
    NSString *fullHex = [UIColor fullHexFrom:string start:start length:length];
    //F becomes FF
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (CGFloat)hexComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length
{
    NSString *fullHex = [UIColor fullHexFrom:string start:start length:length];
    //F becomes FF
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent;
}

@end
