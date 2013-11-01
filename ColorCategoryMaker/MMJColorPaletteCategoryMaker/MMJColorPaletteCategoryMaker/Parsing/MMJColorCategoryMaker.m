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

#pragma mark - Public

+ (void)getFileBodiesForColorCategoryNamed:(NSString *)colorCategoryName withColorDictionary:(NSDictionary *)colorDictionary withReturnBlock:(void (^)(NSString *interfaceFileName, NSString *implementationFileName, NSString *interfaceBody, NSString *implementationBody, NSError *error))block
{
    __block NSMutableString *implementationBodyString = [[NSMutableString alloc] init];
    __block NSMutableString *interfaceBodyString = [[NSMutableString alloc] init];
    
    //append interface with interface start
    [interfaceBodyString appendString:[NSString stringWithFormat:INTERFACE_START_STRING, colorCategoryName]];
    
    //append implementation with implenetation start
    [implementationBodyString appendString:[NSString stringWithFormat:IMPLEMENTATION_START_STRING, colorCategoryName]];
    
    //get all color names from dictionary
    NSArray *colorNames = [colorDictionary allKeys];
    
    //for each color in dictionary
    [colorNames enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        NSString *colorName = (NSString *)object;
        
        //generate method name
        NSString *methodNameString = [NSString stringWithFormat:METHOD_NAME_STRING, colorCategoryName, colorName];
        
        //for interface - > in new line, append ; at the end of the method declaration
        [interfaceBodyString appendString:[NSString stringWithFormat:@"\n%@;", methodNameString]];
        
        //get method body string from color and methodName
        UIColor *color = [colorDictionary objectForKey:colorName];
        NSString *methodBodyString = [MMJColorCategoryMaker colorMethodBodyFromColor:color withName:methodNameString];
        
        //add method body to implementation
        //in new line, append ; at the end of the method declaration
        [implementationBodyString appendString:[NSString stringWithFormat:@"\n%@;\n", methodBodyString]];
    }];
    
    //appent end
    [implementationBodyString appendString:INTERFACE_IMPLEMENTATION_END_STRING];
    [interfaceBodyString appendString:INTERFACE_IMPLEMENTATION_END_STRING];
    
    NSString *interfaceFN = [NSString stringWithFormat:INTERFACE_FILE_NAME, colorCategoryName];
    NSString * implementationFN = [NSString stringWithFormat:IMPLEMENTATION_FILE_NAME, colorCategoryName];
    
    //return values to the caller
    if (block)
        block(interfaceFN, implementationFN,  interfaceBodyString, implementationBodyString, nil);
}

@end
