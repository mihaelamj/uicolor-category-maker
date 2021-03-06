//
//  MMJGenericColorParser.m
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 01/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJGenericColorParser.h"
#import "UIColor+HexString.h"

#define DEFAULT_COLOR_NAME_INDEX 0
#define DEFAULT_COLOR_HEXCODE_INDEX 1

@interface MMJGenericColorParser()
@property (nonatomic) int colorNameIndex;
@property (nonatomic) int colorHexCodeIndex;
@end

@implementation MMJGenericColorParser

#pragma mark - Initializers

- (id)initWithFileName:(NSString *)fileName fileType:(NSString *)fileType colorNameIndex:(int)colorNameIndex colorHexCodeIndex:(int)colorHexCodeIndex
{
    self = [super initWithFileName:fileName fileType:fileType];
    if (self) {
        _colorNameIndex = colorNameIndex;
        _colorHexCodeIndex = colorHexCodeIndex;
    }
    return self;
}

- (id)initWithFileName:(NSString *)fileName fileType:(NSString *)fileType
{
    //give default indexes to initializer
    return [self initWithFileName:fileName fileType:fileType colorNameIndex:DEFAULT_COLOR_NAME_INDEX colorHexCodeIndex:DEFAULT_COLOR_HEXCODE_INDEX];
}

#pragma mark - Overrides
/**
 *  Changes the line to fit the parser, virtual
 *
 *  @param lineString one line from input file
 *
 *  @return correctly formed string for parsing
 */
- (NSString *)cleanLineString:(NSString *)lineString
{
    return lineString;
}

/**
 *  Generic parser expecting (colorname hexvalue) lines
 *
 *  @param colorArray 
 *
 *  @return NSDictionary with colorname : color parts dictionary @{@"alpha":@alphaPart, @"red":@redPart, @"green":@greenPart, @"blue":@bluePart}
 */
- (NSDictionary *)parseColorArrayIntoDictionary:(NSArray *)colorArray
{
    __block NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    
    [colorArray enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        //get one line string
        NSString *namedHexColor = (NSString *)object;
        namedHexColor = [self cleanLineString:namedHexColor];
        
        NSArray *oneColorArray = [namedHexColor componentsSeparatedByString:@" "];
        
        if (([oneColorArray count] > self.colorNameIndex) && ([oneColorArray count] > self.colorHexCodeIndex)) {
            NSString *key = [oneColorArray objectAtIndex:self.colorNameIndex];
            NSString *colorHex = [oneColorArray objectAtIndex:self.colorHexCodeIndex];
            
            NSDictionary *colorComponents = [UIColor colorComponentsForHexString:colorHex];
            [resultDict setObject:colorComponents forKey:key];
//            NSLog(@"key: %@\n, colorColponents: %@", key, colorComponents);
        }
    }];
    
    return [NSDictionary dictionaryWithDictionary:resultDict];
}

#pragma mark - Class methods

+ (NSDictionary *)genericColorsDictionaryWithFileName:(NSString *)fileName fileType:(NSString *)fileType
{
    MMJGenericColorParser *parser = [[MMJGenericColorParser alloc] initWithFileName:fileName fileType:fileType];
    return [parser parse];
}

+ (NSDictionary *)genericColorsDictionaryWithFileName:(NSString *)fileName fileType:(NSString *)fileType colorNameIndex:(int)colorNameIndex colorHexCodeIndex:(int)colorHexCodeIndex
{
    MMJGenericColorParser *parser = [[MMJGenericColorParser alloc] initWithFileName:fileName fileType:fileType colorNameIndex:(int)colorNameIndex colorHexCodeIndex:(int)colorHexCodeIndex];
    return [parser parse];
}

@end
