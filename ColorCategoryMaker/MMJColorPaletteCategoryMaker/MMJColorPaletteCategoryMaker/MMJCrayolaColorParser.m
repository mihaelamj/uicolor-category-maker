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

- (NSString *)sanitizedColorNameFromLineString:(NSString *)lineString
{
    //find the # character
    NSRange hashRange = [lineString rangeOfString:@"#"];
    //copy till # -> "21	Burnt Sienna	"
    NSString *colorName = [lineString substringWithRange:NSMakeRange(0, hashRange.location - 1)];
    
    //remove numbers from color name -> "	Burnt Sienna    "
    colorName = [self stringWithoutNumbers:colorName];
    //remove brackets and ' from color name
    colorName = [self stringWithGoodCharacters:colorName];
    //remove spaces from color name - > "BurntSienna"
    colorName = [self stringWithoutSpaces:colorName];
    
    return colorName;
}

- (NSString *)sanitizedColorHexFromLineString:(NSString *)lineString
{
    //find the # character
    NSRange hashRange = [lineString rangeOfString:@"#"];
    //find the ( characyer
    NSRange lBracket = [lineString rangeOfString:@"("];
   //copy from # to ( -> "#EA7E5D	"
    NSString *colorHex = [lineString substringWithRange:NSMakeRange(hashRange.location, lBracket.location - hashRange.location-1)];
    //remove spaces from color hex - > "BurntSienna"
    colorHex = [self stringWithoutSpaces:colorHex];
    
    return colorHex;
}

#pragma  mark - Public overrides

- (NSString *)cleanLineString:(NSString *)lineString
{
//21	Burnt Sienna	#EA7E5D	(234, 126, 93)	48	1949
    NSString *colorName = [self sanitizedColorNameFromLineString:lineString]; //BurntSienna
    NSString *colorHex = [self sanitizedColorHexFromLineString:lineString]; //#EA7E5D
    
    return [NSString stringWithFormat:@"%@ %@", colorName, colorHex];
}

#pragma mark - Class methods

+ (NSDictionary *)crayolaColorsDictionary
{
    MMJCrayolaColorParser *parser = [[MMJCrayolaColorParser alloc] initWithFileName:@"Crayola" fileType:@"txt"];
    return [parser parse];
}

@end
