//
//  MMJGenericColorParser.m
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 01/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJGenericColorParser.h"
#import "UIColor+HexString.h"

@implementation MMJGenericColorParser
#pragma mark - Overrides

/**
 *  Generic parser expecting colorname hexvalue lines
 *
 *  @param colorArray 
 *
 *  @return NSDictionary with colorname : hexvalue pairs
 */
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

+ (NSDictionary *)genericColorsDictionaryWithFileName:(NSString *)fileName fileType:(NSString *)fileType
{
    MMJGenericColorParser *parser = [[MMJGenericColorParser alloc] initWithFileName:fileName fileType:fileType];
    return [parser parse];
}
@end
