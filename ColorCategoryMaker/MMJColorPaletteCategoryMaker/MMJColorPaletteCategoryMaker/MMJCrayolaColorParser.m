//
//  MMJCrayolaColorParser.m
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 02/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJCrayolaColorParser.h"

@implementation MMJCrayolaColorParser

#pragma  mark - Private

- (NSString *)stringWithoutNumbers:(NSString *)string
{
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSString *result  = [[string componentsSeparatedByCharactersInSet:numbers] componentsJoinedByString:@""];
    return result;
}

- (NSString *)stringWithoutSpaces:(NSString *)string
{
    NSCharacterSet *spaces = [NSCharacterSet characterSetWithCharactersInString:@" "];
    NSString *result = [[string componentsSeparatedByCharactersInSet:spaces] componentsJoinedByString:@""];
    return result;
}

- (NSString *)stringWithGoodCharacters:(NSString *)string
{
    NSCharacterSet *spaces = [NSCharacterSet characterSetWithCharactersInString:@"()'"];
    NSString *result = [[string componentsSeparatedByCharactersInSet:spaces] componentsJoinedByString:@""];
    return result;
}

- (NSString *)sanitizedColorNameFromLineString:(NSString *)lineStringPart
{
     //"121 Violet (Purple) "
    //remove numbers from color name -> "	Violet (Purple)  "
    NSString *colorName = [self stringWithoutNumbers:lineStringPart];
    //remove brackets and ' from color name -> "	Violet Purple  "
    colorName = [self stringWithGoodCharacters:colorName];
    //remove spaces from color name - > "VioletPurple"
    colorName = [self stringWithoutSpaces:colorName];
    
    return colorName;
}

- (NSString *)sanitizedColorHexFromLineString:(NSString *)lineStringPart
{
    NSRange hashRange = [lineStringPart rangeOfString:@"#"];
    //find the ( characyer
    NSRange lBracket = [lineStringPart rangeOfString:@"("];
    //copy from # to ( -> "#EA7E5D	"
    NSString *colorHex = [lineStringPart substringWithRange:NSMakeRange(hashRange.location, lBracket.location - hashRange.location-1)];
    //remove spaces from color hex - > "BurntSienna"
    colorHex = [self stringWithoutSpaces:colorHex];
    
    return colorHex;
}

#pragma  mark - Public overrides

- (NSString *)cleanLineString:(NSString *)lineString
{
    //"121 Violet (Purple) #926EAE (146, 110, 174) 8 1903 "
    //find the # character
    NSRange hashRange = [lineString rangeOfString:@"#"];
    
    NSString *colorName = [lineString substringToIndex:hashRange.location-1];
    colorName = [self sanitizedColorNameFromLineString:colorName];
    
    NSString *colorHex =[lineString substringFromIndex:hashRange.location];
    colorHex = [self sanitizedColorHexFromLineString:colorHex];

    return [NSString stringWithFormat:@"%@ %@", colorName, colorHex];
}

#pragma mark - Class methods

+ (NSDictionary *)crayolaColorsDictionary
{
    MMJCrayolaColorParser *parser = [[MMJCrayolaColorParser alloc] initWithFileName:@"Crayola" fileType:@"txt"];
    return [parser parse];
}

@end
