//
//  MMJColorCategoryMaker.m
//  NiceColors
//
//  Created by Mihaela Mihaljević Jakić on 30/10/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJColorCategoryMaker.h"

#define INTERFACE_FILE_NAME @"UIColor+%@.h"
#define INTERFACE_START_STRING @"@interface UIColor (%@)\n"
#define INTERFACE_IMPLEMENTATION_END_STRING @"\n@end"

#define IMPLEMENTATION_FILE_NAME @"UIColor+%@.m"
#define IMPLEMENTATION_START_STRING @"@implementation UIColor (%@)\n"

#define METHOD_NAME_STRING @"+(UIColor *)%@_%@_Color"
#define METHOD_BODY_STRING @"%@ \n{\n\treturn [UIColor colorWithRed:%f green:%f blue:%f alpha:1.0];\n}"

#define METHOD_BODY_STRING_COMPONENTS @"%@ \n{\n\treturn [UIColor colorWithRed:%d/255.0 green:%d/255.0 blue:%d/255.0 alpha:%d/255.0];\n}"

#define IMPORT_HEADER @"#import \"%@\"\n\n" 

#define HEADER_COMMENTS @"//\n// %@\n//\n//\n// Generated by https://github.com/mihaelamj/uicolor-category-maker\n// Created by Mihaela Mihaljević Jakić\n// Color codes source: %@\n//\n//\n\n"


//  Created by Mihaela Mihaljević Jakić on 02/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.

@implementation MMJColorCategoryMaker

#pragma mark - Helpers

+ (NSString *)colorMethodBodyFromColor:(UIColor *)color withName:(NSString *)methodName;
{
    //get color and split it in components
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat redValue = components[0];
    CGFloat greenValue = components[1];
    CGFloat blueValue = components[2];
    
    //generate method body with components
    return[NSString stringWithFormat:METHOD_BODY_STRING, methodName, redValue, greenValue, blueValue];
}

+ (NSString *)colorMethodBodyFromColorComponents:(NSDictionary *)colorComponents withName:(NSString *)methodName;
{
    int redPart = [[colorComponents objectForKey:@"red"] intValue];
    int greenPart = [[colorComponents objectForKey:@"green"] intValue];
    int bluePart = [[colorComponents objectForKey:@"blue"] intValue];
    int alphaPart = [[colorComponents objectForKey:@"alpha"] intValue];
    
    //generate method body with components
    return[NSString stringWithFormat:METHOD_BODY_STRING_COMPONENTS, methodName, redPart, greenPart, bluePart, alphaPart];
}

+ (NSString *)headerCommentsForFileName:(NSString *)fileName colorCodesSource:(NSString *)colorCodesSource
{
    return [NSString stringWithFormat:HEADER_COMMENTS, fileName, colorCodesSource];
}

+ (NSString *)stringCapitilized:(NSString *)string
{
    NSString *lowerStr = [string lowercaseString];
    return [NSString stringWithFormat:@"%@%@",[[lowerStr substringToIndex:1] uppercaseString],[lowerStr substringFromIndex:1]];
}

+ (NSArray *)sortByName:(NSArray *)colorsArray;
{
    NSArray *sortedArray = [colorsArray sortedArrayUsingComparator:^NSComparisonResult(id id1, id id2) {
        return [(NSString *)id1 compare:(NSString *)id2];
    }];
    return sortedArray;
}

#pragma mark - Public

+ (void)getFileBodiesForColorCategoryNamed:(NSString *)colorCategoryName withColorDictionary:(NSDictionary *)colorDictionary colorCodesSource:(NSString *)colorCodesSource withReturnBlock:(void (^)(NSString *interfaceFileName, NSString *implementationFileName, NSString *interfaceBody, NSString *implementationBody, NSError *error))block
{
#warning implement error
    __block NSMutableString *implementationBodyString = [[NSMutableString alloc] init];
    __block NSMutableString *interfaceBodyString = [[NSMutableString alloc] init];
    
    NSString *capitilizedCategoryName = [self stringCapitilized:colorCategoryName];
    
    NSString *interfaceFN = [NSString stringWithFormat:INTERFACE_FILE_NAME, capitilizedCategoryName];
    NSString *implementationFN = [NSString stringWithFormat:IMPLEMENTATION_FILE_NAME, capitilizedCategoryName];
    
    //INTERFACE
    
    //append header comments to interface
    [interfaceBodyString appendString:[MMJColorCategoryMaker headerCommentsForFileName:interfaceFN colorCodesSource:colorCodesSource]];
    //append interface with interface start
    [interfaceBodyString appendString:[NSString stringWithFormat:INTERFACE_START_STRING, capitilizedCategoryName]];
    
    //IMPEMENTATION
    
    //append header comments to implementation
    [implementationBodyString appendString:[MMJColorCategoryMaker headerCommentsForFileName:implementationFN colorCodesSource:colorCodesSource]];
    //append import header
    [implementationBodyString appendString:[NSString stringWithFormat:IMPORT_HEADER, interfaceFN]];
    //append implementation with implenetation start
    [implementationBodyString appendString:[NSString stringWithFormat:IMPLEMENTATION_START_STRING, capitilizedCategoryName]];
    
    
    //get all color names from dictionary
    NSArray *colorNames = [colorDictionary allKeys];
    
    //sort colorNames by names
    colorNames = [MMJColorCategoryMaker sortByName:colorNames];
    
    //for each color in dictionary
    [colorNames enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        NSString *colorName = (NSString *)object ;
        
        //generate method name
        NSString *methodNameString = [NSString stringWithFormat:METHOD_NAME_STRING, [colorCategoryName lowercaseString], colorName];
        
        //for interface - > in new line, append ; at the end of the method declaration
        [interfaceBodyString appendString:[NSString stringWithFormat:@"\n%@;", methodNameString]];
        
        NSDictionary *colorComponents = [colorDictionary objectForKey:colorName];
        
        //get method body string from color and methodName
        NSString *methodBodyString = [MMJColorCategoryMaker colorMethodBodyFromColorComponents:colorComponents withName:methodNameString];
        //colorMethodBodyFromColorComponents
        
        //add method body to implementation
        //in new line, append ; at the end of the method declaration
        [implementationBodyString appendString:[NSString stringWithFormat:@"\n%@;\n", methodBodyString]];
    }];
    
    //appent end
    [implementationBodyString appendString:INTERFACE_IMPLEMENTATION_END_STRING];
    [interfaceBodyString appendString:INTERFACE_IMPLEMENTATION_END_STRING];

    
    //return values to the caller
    if (block)
        block(interfaceFN, implementationFN,  interfaceBodyString, implementationBodyString, nil);
}

@end
