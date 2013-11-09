//
//  NSString+MMJUtils.m
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 09/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "NSString+MMJUtils.h"

@implementation NSString (MMJUtils)

- (NSString *)stringCapitilized
{
    NSString *lowerStr = [self lowercaseString];
    return [NSString stringWithFormat:@"%@%@",[[lowerStr substringToIndex:1] uppercaseString],[lowerStr substringFromIndex:1]];
}

+ (NSString *)stringPaddedWithString:(NSString *)string length:(int)length
{
    NSString *placeholder = @"%-#.#@";
    NSString *paddingFormat = [placeholder stringByReplacingOccurrencesOfString:@"#" withString:[NSString stringWithFormat:@"%d", length]];
    
    NSString *padded = [NSString stringWithFormat:paddingFormat, string];
    
    return padded;
}

@end
