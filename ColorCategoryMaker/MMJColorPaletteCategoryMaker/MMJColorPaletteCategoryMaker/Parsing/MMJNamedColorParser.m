//
//  MMJNamedColorParser.m
//  NiceColors
//
//  Created by Mihaela Mihaljević Jakić on 29/10/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJNamedColorParser.h"

@interface MMJNamedColorParser()
@property (strong, nonatomic) NSString *fileName;
@property (strong, nonatomic) NSString *fileType;
@property (strong, nonatomic) NSDictionary *namedColorsDictionary;
@end

@implementation MMJNamedColorParser

#pragma mark - Initializer

- (id)initWithFileName:(NSString *)fileName fileType:(NSString *)fileType
{
    self = [super init];
    if (self) {
        _fileName = fileName;
        _fileType = fileType;
    }
    return self;
}

#pragma mark - Helpers

- (NSString *)removeExtraSpaces:(NSString *)string
{
    NSString *goodLine = [NSString stringWithString:string];
    while ([goodLine rangeOfString:@"  "].location != NSNotFound) {
        goodLine = [goodLine stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    };
    return goodLine;
}

- (NSString *)removeTabs:(NSString *)string
{
    NSString *goodLine = [NSString stringWithString:string];
    while ([goodLine rangeOfString:@"\t"].location != NSNotFound) {
        goodLine = [goodLine stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    };
    return goodLine;
}


- (NSString *)getStringFromFileNamed:(NSString *)fileName withType:(NSString *)type encoding:(NSStringEncoding)encoding
{
    NSString *file = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:type];
	NSString *fileString = [NSString stringWithContentsOfFile:file usedEncoding:&encoding error:nil];
    return fileString;
}

#pragma mark - Parsing
/**
 *  Breaks file string into array by line breaks and sanitizes string lines
 *
 *  @return NSDictionary with colorname : hexvalue pairs
 */
- (NSDictionary *)parse
{
    NSStringEncoding endcoding = 0;
    NSString *colorHexString = [self getStringFromFileNamed:self.fileName withType:self.fileType encoding:endcoding];
    
    colorHexString = [self removeTabs:colorHexString];
    colorHexString = [self removeExtraSpaces:colorHexString];
    
    NSArray *colorHexArray = [colorHexString componentsSeparatedByString:@"\n"];
    
    return [self parseColorArrayIntoDictionary:colorHexArray];
}

//abstract
/**
 *  Abstract method that needs to be overriden
 *
 *  @param colorArray
 *
 *  @return NSDictionary with colorname : hexvalue pairs
 */
- (NSDictionary *)parseColorArrayIntoDictionary:(NSArray *)colorArray
{
    return nil;
}

@end
