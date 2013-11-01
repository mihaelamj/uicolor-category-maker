//
//  MMJCopicColorParser.m
//  NiceColors
//
//  Created by Mihaela Mihaljević Jakić on 29/10/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJCopicColorParser.h"
#import "UIColor+HexString.h"

@interface MMJCopicColorParser()

@end

@implementation MMJCopicColorParser

#pragma mark - Overrides

- (NSDictionary *)parseColorArrayIntoDictionary:(NSArray *)colorArray
{
    __block NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    
    [colorArray enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        NSString *namedHexColor = (NSString *)object;
        
        NSArray *oneColorArray = [namedHexColor componentsSeparatedByString:@" "];
        NSString *key = [oneColorArray objectAtIndex:0];
        NSString *colorHex = [oneColorArray objectAtIndex:1];
        
        UIColor *color = [UIColor colorWithHexString:colorHex];
        [resultDict setObject:color forKey:key];
    }];
    
    return [NSDictionary dictionaryWithDictionary:resultDict];
}

#pragma mark - Class methods

+ (NSDictionary *)copicColorsDictionary
{
    MMJCopicColorParser *parser = [[MMJCopicColorParser alloc] initWithFileName:@"Copic_Color_HEX_CODE" fileType:@"txt"];
    return [parser parse];
}

@end
